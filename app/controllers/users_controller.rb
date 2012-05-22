# coding: utf-8

class UsersController < ApplicationController
  
  before_filter :signed_in_user, except: [:new, :create]
  before_filter :signed_in_redirect, only: [:new, :create]

  before_filter :correct_user, only: [:edit, :update, :destroy]

  layout "frontend", only: [:create, :new]


  def index
    if query = params[:search]
      @users = User.search(query) if query != ""      
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
    case params[:setup]
    when "avatar"
      if @user.remember_token == "QTnRYxvylSjndPL5T40fNw"
        current_user.setting.facebook_avatar = open("#{current_user.facebook.picture('large')}")
        current_user.setting.save
        store_settings        
        redirect_to edit_user_path(current_user), :flash => { :success => "Aktualizacja avatara udana" }
      else
        redirect_to edit_user_path(current_user), :flash => { :error => "Brak uprawnień" }
      end
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to bookmarklet_path
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

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
