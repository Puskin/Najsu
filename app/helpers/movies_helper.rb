module MoviesHelper

	def users_liked(movie)
		text = ""
		movie.votes.likes.each do |vote|
			text += render :text => "#{vote.user.name}, "
		end
		text
	end

	def users_disliked(movie)
		text = ""
		movie.votes.dislikes.each do |vote|
			text += render :text => "#{vote.user.name}, "
		end
		text
	end


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
