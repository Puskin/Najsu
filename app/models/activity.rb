class Activity < ActiveRecord::Base
	attr_accessible :user_id, :recipient_id, :resource, :action, :data, :own
	serialize :data
	belongs_to :user

	#status codes for activities actions
	LIKE		 = 1
	COMMENT  = 2
	RELATION = 3

	CREATE 	 = 1
	EDIT 		 = 2
	DESTROY  = 3

	
	private

		def self.log_data(resource, resource_type)

			unless resource_type == RELATION
				#find movie related to resource
				movie = Movie.find(resource.movie_id)
				user_id = resource.user_id
				recipient_id = movie.user_id
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
			when RELATION				 
				user_id = resource.follower_id
				recipient_id = resource.followed_id
				data = {
					:relationship_id => resource.id
				}
			end

			if user_id == recipient_id 
				own_activity = true 
			else
				own_activity = false
			end
		
			self.create(
	      :user_id => user_id, 
	      :recipient_id => recipient_id,
	      :resource => resource_type,
	      :action => CREATE,
	      :data => data,
	      :own => own_activity
	    )
		end



end
