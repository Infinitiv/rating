class Chair < ActiveRecord::Base
  belongs_to :faculty
  has_many :employees
  
  def rating(year)
    rating = 0.0
    self.employees.each do |e|
      rating += e.rating(year)
    end
    self.employees.count > 0 ? rating = rating/self.employees.count : rating = 0.0
  end
end
