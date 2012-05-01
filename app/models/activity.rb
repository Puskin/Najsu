class Activity < ActiveRecord::Base
	attr_accessible :user_id, :recipient_id, :resource, :action, :data
	serialize :data
	belongs_to :user

	#status codes for activities actions
	LIKE		 = 1
	COMMENT  = 2
	FOLLOW 	 = 3

	CREATE 	 = 1
	EDIT 		 = 2
	DESTROY  = 3

	
	private

		def self.log_data(resource, resource_type)

			unless resource_type == FOLLOW
				#find movie related to resource
				movie = Movie.find(resource.movie_id)
				data = {
					:movie_id => movie.id, 
					:movie_title => movie.title, 
					:movie_thumbnail => movie.thumbnail,
					:movie_user_id => movie.user_id,
					:movie_user_name => movie.user.name,
					:resource_id => resource.id
				}
			end

			case resource_type
			when COMMENT
				data[:comment_content] = resource.content
			end
		
			self.create(
	      :user_id => resource.user_id, 
	      :recipient_id => movie.user_id,
	      :resource => resource_type,
	      :action => CREATE,
	      :data => data
	    )
		end



end
