module PagesHelper

	def active?(controller="pages",item)
		if controller_name==controller && action_name == item
			"active"		
		end
	end

end
