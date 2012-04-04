class VotesController < ApplicationController

  layout "frontend"

  def create
  	vote = Vote.new(params[:vote])
    vote.user_id = 4 #will be replaced with current_user.id
	 	case params[:commit]
    when "Nice"
      vote.nice
    when "Bad"
      vote.bad
    end
    respond_to do |format|
    	format.html
    	format.js
    end
  end

  def update
  end

end
