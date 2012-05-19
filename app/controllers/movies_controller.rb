class MoviesController < ApplicationController
 
  before_filter :signed_in_user, except: [:show, :index]
  before_filter :correct_user, only: [:destroy]
  before_filter :authenticate, only: [:new]

  layout "clean", only: [:show]


  def index    
    @movies = Movie.order('id ASC').first(2)  #limited to two for import testing purpose
    respond_to do |format|
      format.xml
      format.json { render json: @movies }
    end  
  end

  def show
    @movie = Movie.find(params[:id])
    @comment = Comment.new
    @movie.views_update    
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def new
    require "open-uri"
    movies = ActiveSupport::JSON.decode(open("http://www.najsu.pl/movies.json"))
    movies.each do |movie|
      mv = Movie.new
      mv.resource_id = movie["resource_id"]
      mv.user_id     = movie["user_id"]
      mv.title       = movie["title"]
      mv.source      = movie["source"]
      mv.thumbnail   = movie["thumbnail"]
      mv.save
    end
    redirect_to root_path, notice: 'Zaimportowano filmy.'     
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(params[:movie])

    respond_to do |format|
      if @movie.save
        format.html { redirect_to root_path, notice: 'Movie was successfully created.' }
        format.json { render json: @movie, status: :created, location: @movie }
      else
        format.html { render action: "new" }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.json
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url }
      format.js
    end
  end



  protected

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "najsu" && password == "2l3uh*&!@^)!(@#4uo23i4&!@^%#"
      end
    end

  private

    def correct_user
      movie = Movie.find(params[:id])
      user = movie.user
      redirect_to(root_path) unless current_user?(user)
    end


end
