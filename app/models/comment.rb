class Comment < ActiveRecord::Base

	validates :content, presence: true
	validates :user_id, presence: true

	belongs_to :movie, :counter_cache => true
	belongs_to :user

	after_save :log_activity

	private

		def log_activity
			Activity.log_data(self, 3)
		end

end
