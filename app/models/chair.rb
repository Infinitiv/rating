class Chair < ActiveRecord::Base
  belongs_to :faculty
  has_many :employees
  has_many :points, :through => :employees
  
  def rating(year)
    self.employees.count == 0 ? 0.0 : self.points.where(year: year).to_a.sum(&:rating)/self.employees.count
  end
end
