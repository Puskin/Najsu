module PagesHelper

	def active?(controller="pages",item)
		if controller_name==controller && action_name == item
			"active"		
		end
	end

	def featuredCss
		colors = [' lightBlue',' darkBlue',' purple', ' green']
		colors[rand(4)]		
	end

end
