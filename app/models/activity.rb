class Activity < ActiveRecord::Base
	attr_accessible :user_id, :recipient_id, :resource, :action, :data
	serialize :data
	belongs_to :user

	
	private

		def self.log_data(resource, resource_type)

			unless resource_type == 4
				#find movie related to resource
				movie = Movie.find(resource.movie_id)
				data = {
					:movie_id => movie.id, 
					:movie_title => movie.title, 
					:movie_user_id => movie.user_id,
					:movie_user_name => movie.user.name,
					:resource_id => resource.id
				}
			end

			case resource_type
			when 3
				data[:comment_content] = resource.content
			end
		
			self.create(
	      :user_id => resource.user_id, 
	      :recipient_id => movie.user_id,
	      :resource => resource_type,
	      :action => 1,
	      :data => data
	    )
		end



end
