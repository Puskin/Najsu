class ActivitiesController < ApplicationController

	layout "frontend"

	def index    
    @activities = current_user.activities_feed
    current_user.activities_visit_update
  end


end
