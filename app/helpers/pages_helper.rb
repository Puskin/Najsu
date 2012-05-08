module PagesHelper

	def active?(controller="pages",item)
		if controller_name==controller && action_name == item
			"active"		
		end
	end

	def featuredCss
		colors = [' lightBlue',' darkBlue',' purple',' orange', ' green']
		colors[rand(5)]		
	end

end
