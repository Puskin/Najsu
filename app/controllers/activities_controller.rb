class ActivitiesController < ApplicationController

	layout "frontend"

	def index    
    followed_users = current_user.followed_users.map(&:id)
    @activities = Activity.where(
      "user_id = :user_id OR recipient_id = :recipient_id",
      { :user_id => followed_users, :recipient_id => current_user.id }
    ).order('created_at DESC')
  end


end
