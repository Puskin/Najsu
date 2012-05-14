class CommentsController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user, only: [:destroy]
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

    def correct_user
      comment = Comment.find(params[:id])
      user = comment.user
      redirect_to(root_path) unless current_user?(user)
    end

end
