class ReportsController < ApplicationController
  def index
  	@average_rating = average_rating
  	@average_rating_assistants = average_rating_assistants
  	@sigma = sigma
  end

  private
  def sigma
	sd ||= Point.first.stdevs[2013]
	sd.each do |s|
		sigma[1] = average_rating + s
		sigma[2] = average_rating + 2 * s
		sigma[3] = average_rating + 3 * s
	end
  end
  def average_rating
  	sum = 0.0
  	employees = Employee.all
  	employees.each do |e|
  		sum += e.rating(2013)
  	end
  	(sum/employees.count).round(2)
  end

  def average_rating_assistants
  	sum = 0.0
  	employees = Employee.find_all_by_post_id(1)
  	employees.each do |e|
  		sum += e.rating(2013)
  	end
  	(sum/employees.count).round(2)  	
  end
end
