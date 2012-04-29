class PagesController < ApplicationController

  include MoviesHelper

  before_filter :signed_in_user, except: [:home, :submit, :timeline, :library]
  layout :layout_switcher

  def home
    @comment = Comment.new
    if signed_in?
      case params[:feed]
      when "newest"
        @movies = Movie.order('created_at DESC').paginate(:page => params[:page])
      when "popular"
        @movies = Movie.order('likes_count DESC, created_at DESC').last_week.paginate(:page => params[:page])
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
      @movies = Movie.order('movies.created_at DESC').paginate(:page => params[:page])
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def library
    case params[:show]    
    when "yours"
      @movies = current_user.reposts.order('created_at DESC')
    when "liked"
      likes = current_user.likes.map(&:movie_id).uniq
      @movies = Repost.find_all_by_movie_id(likes)
    when "commented"
      comments = current_user.comments.map(&:movie_id).uniq
      @movies = Repost.find_all_by_movie_id(comments)
    else
      @movies = current_user.reposts.order('created_at DESC')
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def timeline
    @movies = Movie.all.group_by { |m| m.created_at.at_beginning_of_day }
  end

  def submit
    if signed_in?
      if params[:resource_id] && params[:resource_title] && params[:resource_source]
        video_id = params[:resource_id]
        video_title = params[:resource_title]
        video_source = params[:resource_source]
        movie_record = Movie.unique?(video_id, video_source)
        if movie_record
          repost = current_user.reposts.find_by_resource_id_and_source(video_id, video_source)
          if repost
            redirect_to :action => "submit", notice: 'Movie already in your library.'     
          else
            thumbnail = thumbnail_url(video_id, video_source)
            Repost.create(:movie_id => movie_record.id, :user_id => current_user.id, :resource_id => video_id, :source => video_source, :thumbnail => thumbnail ) 
            Like.find_or_create_by_user_id_and_movie_id(:user_id => current_user.id, :movie_id => movie_record.id)
            redirect_to :action => "submit", notice: 'Movie added to library.'     
          end
        else
          thumbnail = thumbnail_url(video_id, video_source)
          movie = Movie.create(:resource_id => video_id, :user_id => current_user.id, :title => video_title, :source => video_source, :thumbnail => thumbnail)
          redirect_to :action => "submit", notice: 'Movie added to library.'    
        end
      end
    end
  end

  private

  	def signed_in_user
      redirect_to root_path if signed_in?
  	end

  	def layout_switcher
  		if action_name == "submit"
  			"clean"
      else
        "frontend"
  		end
  	end

end
