class Like < ActiveRecord::Base

	belongs_to :movie, :counter_cache => true
	belongs_to :user

	def update
		like = Like.conn(self.movie_id, self.user_id)
		if like
			like.destroy
		else
			self.save!
		end
	end	

  class << self 

		def conn(movie_id, user_id)
			like = find_by_movie_id_and_user_id(movie_id, user_id)
			if like
				like
			else
				false
			end
	  end 

	end
  
end
