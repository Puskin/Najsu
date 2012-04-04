class Vote < ActiveRecord::Base

	belongs_to :movie
	belongs_to :user

	def nice
		vote = Vote.conn(self.movie_id, self.user_id)
		if vote
			vote.update_attributes!(:character => 1)
		else
			self.character = 1
			save!
		end
	end	

	def bad
		vote = Vote.conn(self.movie_id, self.user_id)
		if vote
			vote.update_attributes!(:character => 0)
		else
			self.character = 0
			save!
		end		
	end


  class << self 

		def conn(movie_id, user_id)
			vote = find_by_movie_id_and_user_id(movie_id, user_id)
			if vote
				vote
			else
				false
			end
	  end 

	end
  
end
