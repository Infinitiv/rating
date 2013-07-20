class Employee < ActiveRecord::Base
  belongs_to :chair
  belongs_to :post
  belongs_to :degree
  belongs_to :academic_title
  has_many :points
  
  def fio
   [last_name, first_name, middle_name].compact.join(' ')
  end
  
  def rating(year)
    p = self.points.find_by_year(year)
    p.nil? ? 0 : p.rating
  end
  
  def head_rating(year)
    head_rating = 0.0
    self.head? ? head_rating = self.rating(year) + self.chair.rating(year)/2 : head_rating = 0.0
  end
end
