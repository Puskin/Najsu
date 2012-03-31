class PagesController < ApplicationController

  before_filter :signed_in_user, except: [:home, :submit]
  layout :layout_switcher

  def home
    @movie = Movie.new
    @movies = Movie.all
  end

  def submit
    if params[:resource_id]
      video_id = params[:resource_id]
      Movie.create(:resource_id => video_id)
      redirect_to :action => "submit", notice: 'Movie added to library.'    
    end
  end

  private

  	def signed_in_user
      redirect_to root_path if signed_in?
  	end

  	def layout_switcher
  		if signed_in? && action_name == "home"
  			"application"
  		elsif action_name == "submit"
  			"clean"
      else
        "frontend"
  		end
  	end

end
