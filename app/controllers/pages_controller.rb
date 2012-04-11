class PagesController < ApplicationController

  before_filter :signed_in_user, except: [:home, :submit, :timeline]
  layout :layout_switcher

  def home
    @movie = Movie.new
    @comment = Comment.new
    if signed_in?
      @movies = current_user.feed
    else
      @movies = Movie.all
    end
  end

  def timeline
    @movies = Movie.all.group_by { |m| m.created_at.at_beginning_of_day }
  end

  def submit
    if signed_in?
      if params[:resource_id]
        video_id = params[:resource_id]
        if current_user.movies.find_by_resource_id(params[:resource_id])
          redirect_to :action => "submit", notice: 'Movie already in library.'    
        else
          movie = Movie.create(:resource_id => video_id, :user_id => current_user.id)
          movie.votes.create(:user_id => current_user.id, :character => 1)
          redirect_to :action => "submit", notice: 'Movie added to library.'    
        end
      end
    end
  end

  private

  	def signed_in_user
      redirect_to root_path if signed_in?
  	end

  	def layout_switcher
  		if action_name == "submit"
  			"clean"
      else
        "frontend"
  		end
  	end

end
