class User < ActiveRecord::Base
  belongs_to :group
  validates :login, :presence => true, 
            :length => { :maximum => 50 }, 
            :uniqueness => true
  validates :password, :confirmation => true,
	    :presence => true
  validates :password_confirmation, :presence => true
  has_secure_password
end
