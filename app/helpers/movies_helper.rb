module MoviesHelper

	def users_liked(movie)
		movie.likes.all.map{|like|like.user.name}.join(", ")
	end

	def thumbnail_url(video_id, source)
		if source.to_i == 1
			return "http://img.youtube.com/vi/#{video_id}/hqdefault.jpg"
		elsif source.to_i == 2
			return vimeo_thumbnail_url(video_id)			
		else
			return "http://img.youtube.com/vi/0/hqdefault.jpg"
		end
	end

	def vimeo_thumbnail_url(vimeo_id)
		require "open-uri"
		video_json = ActiveSupport::JSON.decode(open("http://vimeo.com/api/v2/video/#{vimeo_id}.json"))
		return video_json[0]["thumbnail_large"]
	end


end
