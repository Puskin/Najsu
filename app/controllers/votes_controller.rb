class VotesController < ApplicationController

  before_filter :signed_in_user
  layout "frontend"

  def create
  	vote = Vote.new(params[:vote])
    vote.user_id = current_user.id
	 	case params[:commit]
    when "Nice"
      vote.nice
    when "Bad"
      vote.bad
    end
    respond_to do |format|
    	format.html
    	format.js { @movie = Movie.find(vote.movie_id) }
    end
  end
  
  private
    
    def signed_in_user
      redirect_to signin_path, notice: "Please sign in" unless signed_in?
    end

end
