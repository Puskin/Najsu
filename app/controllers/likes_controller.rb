class LikesController < ApplicationController

  before_filter :signed_in_user

  def create
  	like = Like.new(params[:like])
    like.user_id = current_user.id
    like.update
    respond_to do |format|
    	format.html
    	format.js { @movie = Movie.find(like.movie_id) }
    end
  end
  
end
