module UsersHelper

	def gravatar_url_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
    gravatar_url
  end

  def gravatar_img_for(user)
  	image_tag(gravatar_url_for(user), alt: user.name, class: "gravatar")
  end

end
