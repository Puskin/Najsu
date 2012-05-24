module UsersHelper

	def avatar_url_for(user)
		if user.facebook?
			fb_avatar_url_for(user)
		else
			gravatar_url_for(user)
		end
	end

	def fb_avatar_url_for(user)
		facebok_url = "http://graph.facebook.com/#{user.fb_uid}/picture?type=square"
		facebok_url
	end

	def gravatar_url_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
    gravatar_url
  end

  def gravatar_img_for(user)
  	image_tag(gravatar_url_for(user), alt: user.name, class: "gravatar")
  end

end
