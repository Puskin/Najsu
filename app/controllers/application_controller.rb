class ApplicationController < ActionController::Base
	
  protect_from_forgery
  include SessionsHelper
  before_filter :check_uri  	 	
  
  def check_uri	
    redirect_to request.protocol + "www." + request.host_with_port + request.request_uri if !/^www/.match(request.host) if Rails.env == 'production'
  end                                           

end
