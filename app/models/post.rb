class Post < ActiveRecord::Base
has_many :employees
has_many :points, :through => :employees
end
