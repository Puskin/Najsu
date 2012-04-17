module MoviesHelper

	def users_liked(movie)
		text = ""
		movie.likes.all.each do |like|
			text += render :text => "#{like.user.name}, "
		end
		text
	end

end
