class Chair < ActiveRecord::Base
  belongs_to :faculty
  has_many :employees
  has_many :points, :through => :employees
  
  def rating(year)
    rating = 0.0
    e = self.employees
    e.each do |e|
      rating += e.rating(year)
    end
    e.count > 0 ? rating = rating/e.count : rating = 0.0
  end
end
