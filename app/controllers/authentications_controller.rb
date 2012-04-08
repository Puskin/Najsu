class AuthenticationsController < ApplicationController

  layout "frontend"
  
  def create
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      sign_in authentication.user
      flash.now[:success] = 'Logged in, welcome back.'
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
      flash.now[:success] = 'Authentication created, close the window, reload the site.'
    else
      user = User.new
      user.apply_omniauth(omniauth)
      user.save!(:validate => false)
      sign_in user
      flash.now[:success] = 'Successfully logged in with facebook, close the window, reload the site.'
    end
  end

end
