module ApplicationHelper

	def page_title(title)
		base_title = "Najsu.pl"
		if title.empty?
			base_title
		else
			"#{base_title} - #{title}"
		end
	end

end
