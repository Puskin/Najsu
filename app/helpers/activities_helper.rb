# coding: utf-8

module ActivitiesHelper

	def activity_action(resource)
		case resource
		when 1
			"dodał film"
		when 2
			"polubił film"
		when 3
			"skomentował film"
		end
	end

end
