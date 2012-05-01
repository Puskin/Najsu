# coding: utf-8

module ActivitiesHelper

	def activity_action(resource)
		case resource		
		when 1
			"polubił film"
		when 2
			"skomentował film"
		when 3
			"zaczął Cię obserwować"
		end
	end

end
