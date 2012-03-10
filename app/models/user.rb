class User < ActiveRecord::Base
	
	attr_accessible :name, :email

	validates :name, :presence => true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,	presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true


end
