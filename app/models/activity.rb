class Activity < ActiveRecord::Base
	attr_accessible :user_id, :recipient_id, :resource, :action, :data, :owner_id
	serialize :data
	belongs_to :user


	scope :feed,   		proc {|user| where("user_id in (?) AND user_id != ?", user.followed_users.map(&:id), user.id) }
	scope :personal,	proc {|user| where("user_id != ? AND recipient_id = ?", user.id, user.id) }
	

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
					:relationship_id => resource.id,
					:followed_user_name => resource.followed.name
				}
			end

			if user_id == recipient_id 
				owner_id = user_id 
			else
				owner_id = 0
			end
		
			self.create(
	      :user_id => user_id, 
	      :recipient_id => recipient_id,
	      :resource => resource_type,
	      :action => CREATE,
	      :data => data,
	      :owner_id => owner_id
	    )
		end



end
