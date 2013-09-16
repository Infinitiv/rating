class Chair < ActiveRecord::Base
  belongs_to :faculty
  has_many :employees
  has_many :points, :through => :employees
  
  def rating
    years = Point.all.map(&:year).uniq.sort
    rating = {}
    names = Point.attribute_names - ["id", "created_at", "updated_at", "year", "employee_id"] + ["inqualification_rating","rating"]
    years.each do |year|
      rating[year] = {}
      points = self.points.where(year: year).to_a
      names.each do |n|
	rating[year][n] = points.length == 0 ? 0.0 : points.sum(&n.to_sym)/points.length
      end
    end
    rating
  end
end
