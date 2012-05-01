class Repost < ActiveRecord::Base

	belongs_to :user
	belongs_to :movie, :counter_cache => true

	#after_save :log_activity

	private

		#not logging reposts for now
		
		#def log_activity
			#Activity.log_data(self, 1)			
		#end

end
