class Employee < ActiveRecord::Base
  belongs_to :chair
  belongs_to :post
  belongs_to :degree
  belongs_to :academic_title
  has_many :points
  
  def fio
    "#{self.last_name} #{self.first_name} #{self.middle_name}"
  end
  
  def rating(year)
    self.points.find_by_year(year).nil? ? 0 : self.points.find_by_year(year).rating 
  end
  
  def head_rating(year)
    head_rating = 0.0
    self.head? ? head_rating = self.rating(year) + self.chair.rating(year)/2 : head_rating = 0.0
  end
end
