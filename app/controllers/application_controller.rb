class ApplicationController < ActionController::Base
	
  protect_from_forgery
  include SessionsHelper

  before_filter :ensure_domain

  APP_DOMAIN = 'www.najsu.pl'

  def ensure_domain
  	if Rails.env == "production"
	    if request.env['HTTP_HOST'] != APP_DOMAIN
	      # HTTP 301 is a "permanent" redirect
	      redirect_to "http://#{APP_DOMAIN}#{request.env['REQUEST_PATH']}", :status => 301
	    end
	   end
  end

end
