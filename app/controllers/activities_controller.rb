class ActivitiesController < ApplicationController

	layout "frontend"

	def index    
    followed_users = current_user.followed_users.map(&:id)
    @activities = Activity.find(:all, :conditions => ["user_id in (?) OR recipient_id = ?", followed_users, current_user.id], :order => 'created_at DESC')
  end


end
