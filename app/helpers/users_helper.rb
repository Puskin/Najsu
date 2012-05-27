# coding: utf-8
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



	# Facebook feed messages helpers
  def fb_invite(uid)
  	user = current_user.fbpost(uid)
    user.feed!(
      :message => "Hej, zapraszam Cię na Najsu.pl - dołącz do moich znajomych i zobacz co oglądam!", 
      :link => "www.najsu.pl", 
      :name => "Najsu.pl", 
      :description => "Odkrywaj najciekawsze filmiki w sieci, na świecie i wśród znajomych, udostępniaj swoje znaleziska!", 
      :picture => "http://www.najsu.pl/assets/faviconBig.png"
    )
  end

  def fb_post(uid)
  	user = current_user.fbpost(uid)
    user.feed!(
      :message => "Korzystam z Najsu.pl przez Facebook - dołącz do moich znajomych i zobacz co oglądam!", 
      :link => "www.najsu.pl", 
      :name => "Najsu.pl", 
      :description => "Odkrywaj najciekawsze filmiki w sieci, na świecie i wśród znajomych, udostępniaj swoje znaleziska!", 
      :picture => "http://www.najsu.pl/assets/faviconBig.png"
    )
    rescue FbGraph::Unauthorized
    	true     
  end


end
