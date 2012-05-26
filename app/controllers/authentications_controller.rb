# coding: utf-8
class AuthenticationsController < ApplicationController

  layout "clean"
  
  def create
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      unless omniauth['credentials']['token'] == authentication.token
        authentication.token = omniauth['credentials']['token']
        authentication.save
      end
      sign_in authentication.user
      @newuser = false #zalogowany autentykowany wczesniej user
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
      @newuser = false #autentykacja zalogowanego zwyczajnie usera
    else
      user = User.new
      user.apply_omniauth(omniauth)
      user.save!(:validate => false)
      sign_in user
      @newuser = true #utworzenie i autentykacja nowego usera    
    end
  end

end
