# coding: utf-8

module ActivitiesHelper

	def activity_decode(activity)

		hash = Hash.new

		author 			= activity.user_id
		recipient 	= activity.recipient_id	
		resource 		= activity.resource
		data 				= activity.data

		if recipient == current_user.id
			activity_recipient = true 
		else
			activity_recipient = false
		end

		if activity.resource !=3
			hash["movie_thumbnail"]  = activity.data[:movie_thumbnail] 
			hash["movie_title"] 		 = activity.data[:movie_title]
		end

		case resource		
		when 1 #like			
			if activity_recipient			
				hash["content"] 	= "polubił Twój film"				
			else
				hash["content"]  = "polubił film #{data[:movie_user_name]}"
			end

		when 2 #comment			
			if activity_recipient			
				hash["content"]  = "skomentował Twój film"			
			else				
				hash["content"]  = "skomentował film #{data[:movie_user_name]}"				
			end

		when 3 #follow
			hash["movie_thumbnail"]  = ""
			hash["movie_title"] 		 = ""
			if activity_recipient
				hash["content"]  = "zaczął Cię obserwować"				
			else				
				hash["content"]  = "zaczął obserwować #{data[:followed_user_name]}"				
			end
		end

		return hash

	end

end
