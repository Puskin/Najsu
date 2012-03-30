class PagesController < ApplicationController

  before_filter :signed_in_user, except: [:home]
	layout :layout_switcher
  
  def home
    @movie = Movie.new
    @movies = Movie.all
  end

  private

  	def signed_in_user
      redirect_to root_path if signed_in?
  	end

  	def layout_switcher
  		if signed_in? && action_name == "home"
  			"application"
  		else
  			"frontend"
  		end
  	end

end
