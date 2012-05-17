# coding: utf-8
class AuthenticationsController < ApplicationController
  
  def create
    omniauth = request.env['omniauth.auth']
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      sign_in authentication.user
      redirect_to root_path
      flash.now[:success] = 'Zalogowano pomyślnie, witaj ponownie.'
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
      flash.now[:success] = 'Autentykacja udana, możesz teraz logować się przez Facebook.'
    else
      user = User.new
      user.apply_omniauth(omniauth)
      user.save!(:validate => false)
      sign_in user
      redirect_to root_path
      flash.now[:success] = 'Z powodzeniem zalogowano przez Facebook, witaj w Najsu!'
    end
  end

end
