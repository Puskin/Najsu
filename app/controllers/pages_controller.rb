# coding: utf-8
class PagesController < ApplicationController

  include MoviesHelper
  before_filter :signed_in_user, only: [:library]
  layout "clean", only: [:submit]

  def home
    @comment = Comment.new
    if signed_in?
      case params[:feed]
      when "newest"
        @movies = Movie.order('created_at DESC').paginate(:page => params[:page])
      when "popular"
        @movies = Movie.order('likes_count DESC, created_at DESC').last_days.paginate(:page => params[:page])
      when "friends"
        @movies = current_user.feed.order('created_at DESC').paginate(:page => params[:page])
      when "discussed"
        @movies = current_user.feed.order('comments_count DESC, created_at DESC').last_week.paginate(:page => params[:page])
      when "watched"
        @movies = Movie.order('views_count DESC, created_at DESC').last_week.paginate(:page => params[:page])
      else 
        @movies = current_user.feed.order('created_at DESC').paginate(:page => params[:page])
      end
    else
      #@movies = Movie.order('movies.created_at DESC').paginate(:page => params[:page])
      #@movies = Movie.order('likes_count DESC, created_at ASC').paginate(:page => params[:page])
      @movies = Movie.order('likes_count DESC, created_at DESC').last_days.paginate(:page => params[:page])
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def library
    case params[:show]    
    when "yours"
      @reposts = current_user.reposts.order('created_at DESC').first(30)
    when "liked"
      likes = current_user.likes.map(&:movie_id)
      @reposts = current_user.reposts.find_all_by_movie_id(likes.uniq,:order => 'created_at DESC').first(30)
      #@reposts = Repost.find_all_by_movie_id_and_user_id(likes.uniq, current_user.id, :order => 'created_at DESC').first(30)
    when "commented"
      comments = current_user.comments.map(&:movie_id)
      #zrobić sobie scope'a do wyświetlania repostów komentowanych przez danego usera
      @reposts = Repost.find_all_by_movie_id(comments.uniq, :order => 'created_at DESC').first(30)
    else
      @reposts = current_user.reposts.order('created_at DESC').first(30)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def bookmarklet    
    respond_to do |format|
      format.js
      format.html { redirect_to signin_path, notice: "Zaloguj się lub załóż konto" unless signed_in? }
    end
  end

  def submit
    if signed_in?
      if params[:resource_id] && params[:resource_title] && params[:resource_source] && params[:resource_source] != "undefined"
        video_id = params[:resource_id]
        video_title = params[:resource_title]
        video_source = params[:resource_source]
        movie_record = Movie.unique?(video_id, video_source)
        if movie_record
          repost = current_user.reposts.find_by_resource_id_and_source(video_id, video_source)
          if repost
            redirect_to :action => "submit", notice: 'Film już istnieje w zbiorach.'     
          else
            thumbnail = thumbnail_url(video_id, video_source)
            Repost.create(:movie_id => movie_record.id, :user_id => current_user.id, :resource_id => video_id, :source => video_source, :thumbnail => thumbnail ) 
            Like.find_or_create_by_user_id_and_movie_id(:user_id => current_user.id, :movie_id => movie_record.id)
            redirect_to :action => "submit", notice: 'Film dodany do zbiorów.'     
          end
        else
          thumbnail = thumbnail_url(video_id, video_source)
          movie = Movie.create(:resource_id => video_id, :user_id => current_user.id, :title => video_title, :source => video_source, :thumbnail => thumbnail)
          redirect_to :action => "submit", notice: 'Film dodany do zbiorów.'    
        end
      end
    end
  end

end
