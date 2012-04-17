class Repost < ActiveRecord::Base

	belongs_to :user
	belongs_to :movie, :counter_cache => true

end
