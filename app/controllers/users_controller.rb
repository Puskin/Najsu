# coding: utf-8

class UsersController < ApplicationController
  before_filter :signed_in_user, except: [:new, :create]
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  layout "frontend", only: [:create, :new]


  def index
    if query = params[:search]
      @users = User.search(query)      
    else
      users_count = User.all.count
      arr = []
      10.times do 
        arr << rand(users_count)
      end
      @users = User.find_all_by_id(arr.uniq)
    end
    respond_to do |format|
      format.html 
      format.js
    end
  end

  

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Tuduk."
      redirect_to root_path
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url   
  end


  private

    def signed_in_user
      redirect_to signin_path, notice: "Zaloguj się najpierw" unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
