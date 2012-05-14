# coding: utf-8

class SessionsController < ApplicationController

	before_filter :signed_in_redirect, only: [:new, :create]
  layout "frontend"

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
			sign_in user
      redirect_to root_path
	  else
      flash.now[:error] = 'Błędna kombinacja e-mail / hasło'
    	render 'new'
    end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
