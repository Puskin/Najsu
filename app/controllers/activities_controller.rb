# coding: utf-8
class ActivitiesController < ApplicationController

	before_filter :signed_in_user

	def index    
		show_count = 50 #number of visible activities
		unseen_count = current_user.activities_counter
		if unseen_count > show_count
			show_count = unseen_count
		end

    respond_to do |format|
      format.html { @activities = Activity.feed(current_user).order('created_at DESC').first(show_count) }
      format.js { @activities = Activity.personal(current_user).order('created_at DESC').first(show_count) }
    end
    @new_activities = current_user.activities_counter
    current_user.activities_visit_update
  end

end
