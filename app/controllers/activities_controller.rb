# coding: utf-8
class ActivitiesController < ApplicationController

	before_filter :signed_in_user

	def index    
    respond_to do |format|
      format.html { @activities = Activity.feed(current_user).order('created_at DESC') }
      format.js { @activities = Activity.personal(current_user).order('created_at DESC').first(25) }
    end
    @new_activities = current_user.activities_counter
    current_user.activities_visit_update
  end

end
