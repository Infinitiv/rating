class Point < ActiveRecord::Base
  belongs_to :employee
  
  def rating
    0.25 * self.qualification + 0.75 * (self.learning + self.science + self.clinic + self.social)
  end
  
  def inqualification_rating
    self.learning + self.science + self.clinic + self.social
  end
  
  def stdevs
    stdevs = {}
    Point.all.map(&:year).uniq.each do |y|
      ratings = Point.find_all_by_year(y).map{|p| p.rating}
      stdevs[y] = [ratings.sum/ratings.length.to_f, ratings.stdev]
    end
    stdevs
  end

  def sigma(rating, year)
    sd ||= stdevs
    if rating < sd[year][0]
      sigma = '< ' + ((rating - sd[year][0])/sd[year][1]).ceil.to_s + 's'
    else
      sigma = '> ' + ((rating - sd[year][0])/sd[year][1]).floor.to_s + 's'
    end
    sigma
  end
end
