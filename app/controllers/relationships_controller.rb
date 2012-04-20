class RelationshipsController < ApplicationController

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
    end
  end
end