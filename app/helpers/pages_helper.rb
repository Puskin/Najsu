module PagesHelper

	def active?(item)
		if action_name == item
			"active"
		end					
	end

end
