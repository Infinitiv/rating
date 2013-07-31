class ReportsController < ApplicationController
  def index
    @years = Point.all.map(&:year).uniq
    @average_rating = {}
    @average_rating_assistant = {}
    @average_rating_docent = {}
    @average_rating_professor = {}
    @average_rating_st_teacher = {}
    @sigma = {}
    @years.each do |year|
      @average_rating[year] = average_rating(year)
      @average_rating_assistant[year] = average_rating(year, 1)
      @average_rating_st_teacher[year] = "%.2f" % average_rating(year, 2)
      @average_rating_docent[year] = "%.2f" % average_rating(year, 3)
      @average_rating_professor[year] = "%.2f" % average_rating(year, 4)
      @sigma[year] = sigma(year)
    end
  end

  private
  def sigma(year)
    sigma = {}
    sd = Point.first.stdevs[year][1]
    ar = average_rating(year)
    sigma[1] = "%.2f" % (ar.to_f + sd)
    sigma[2] = "%.2f" % (ar.to_f + 2 * sd)
    sigma[3] = "%.2f" % (ar.to_f + 3 * sd)
    sigma
  end
  
  def average_rating(year, post = nil)
    ratings = post ? Point.where(year: year).joins(:employee).where(employees: {post_id: post}).map{|p| p.rating} : Point.where(year: year).joins(:employee).where.not(employees: {post_id: post}).map{|p| p.rating}
    sum = "%.2f" % (ratings.sum/ratings.length.to_f)
  end

end
