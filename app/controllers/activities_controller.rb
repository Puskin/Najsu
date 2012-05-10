# coding: utf-8


class ActivitiesController < ApplicationController

	before_filter :signed_in_user
	layout "application"

	def index    
    respond_to do |format|
      format.html { @activities = current_user.activities_feed }
      format.js { @activities = current_user.activities_personal.first(25) }
    end
    @new_activities = current_user.activities_counter
    current_user.activities_visit_update
  end

  private

  	def signed_in_user
      redirect_to signin_path, notice: "Zaloguj się najpierw" unless signed_in?
    end


end
