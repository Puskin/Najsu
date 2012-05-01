class ActivitiesController < ApplicationController

	layout "frontend"

	def index    
    @activities = current_user.activities_feed
  end


end
