module MoviesHelper

	def voteClassNice(vote_character)
		if vote_character == 1
			"active"
		else
			""
		end
	end

	def voteClassBad(vote_character)
		if vote_character == 0
			"active"
		else
			""
		end
	end

end
