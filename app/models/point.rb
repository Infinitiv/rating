class Point < ActiveRecord::Base
  belongs_to :employee
  
  def rating
    0.25 * self.qualification + 0.75 * (self.learning + self.science + self.clinic + self.social)
  end
end
