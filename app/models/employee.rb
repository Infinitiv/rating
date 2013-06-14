class Employee < ActiveRecord::Base
  belongs_to :chair
  belongs_to :post
  belongs_to :degree
  belongs_to :academic_title
  has_many :points
end
