class ReportsController < ApplicationController
  skip_before_action :require_login
  def index
    @years = Point.all.map(&:year).uniq
    @posts = Post.all
    @faculties = Faculty.all
    @average_rating = average_rating
  end

  private
  def sigma(ratings)
    sigma = []
    ratings.each do |rating|
      stdev = rating.length > 0 ? rating.stdev : 0
      average = rating.length > 0 ? rating.sum/rating.length.to_f : 0
      sigma += ["%.2f" % (rating.select{|p| p < (average.to_f + stdev)}.count.to_f*100/rating.count)]
      sigma += ["%.2f" % (rating.select{|p| p > (average.to_f + stdev) and p < (average.to_f + 2 * stdev)}.count.to_f*100/rating.count)]
      sigma += ["%.2f" % (rating.select{|p| p > (average.to_f + 2 * stdev)}.count.to_f*100/rating.count)]
    end
    sigma
  end
  
  def average_rating
    average_rating = {}
    years = Point.all.map(&:year).uniq
    posts = Post.all.map(&:id).uniq
    faculties = Faculty.all.map(&:id).uniq
    years.each do |year|
	  average_rating[year] ||= {}
	  ratings = Point.where(year: year).joins(:employee).joins(:chair).map{|p| [p.rating, p.inqualification_rating]}.transpose
	  sum = sum(ratings)
	  average_rating[year][:total] = sum if sum
      posts.each do |post|
	  average_rating[year][post] ||= {}
	  ratings = Point.where(year: year).joins(:employee).joins(:chair).where(employees: {post_id: post}).map{|p| [p.rating, p.inqualification_rating]}.transpose
	  sum = sum(ratings)
	  average_rating[year][post][:total] = sum if sum
	  sigma = sigma(ratings)
	  average_rating[year][post][:sigma] = sigma if sigma
	faculties.each do |faculty|
	  ratings = Point.where(year: year).joins(:employee).joins(:chair).where(employees: {post_id: post}, chairs: {faculty_id: faculty}).map{|p| [p.rating, p.inqualification_rating]}.transpose
	  sum = sum(ratings)
	  average_rating[year][post][faculty] = sum if sum
	end
    ratings = Point.where(year: year).joins(:employee).joins(:chair).where(employees: {post_id: post}, chairs: {clinic: true}).map{|p| [p.rating, p.inqualification_rating]}.transpose
    sum = sum(ratings)
    average_rating[year][post][:clinical] = sum if sum
    ratings = Point.where(year: year).joins(:employee).joins(:chair).where(employees: {post_id: post}, chairs: {clinic: false}).map{|p| [p.rating, p.inqualification_rating]}.transpose
    sum = sum(ratings)
    average_rating[year][post][:teoretical] = sum if sum
      end
    end
    average_rating
  end
  
  def sum(ratings)
    sum = []
    ratings.each do |rating|
      sum += rating.length > 0 ? ["%.2f" % (rating.sum/rating.length.to_f)] : [0]
    end
    sum
  end
end
