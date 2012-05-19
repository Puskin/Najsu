class MoviesController < ApplicationController
 
  before_filter :signed_in_user, except: [:show]
  before_filter :correct_user, only: [:destroy]

  layout "clean", only: [:show]


  def index
    if params[:popular] == "fuckyea"
      @movies = Movie.order('likes_count DESC').paginate(:page => params[:page])
    else
      @movies = Movie.all
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
    @movie = Movie.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movie }
    end
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

  private

    def correct_user
      movie = Movie.find(params[:id])
      user = movie.user
      redirect_to(root_path) unless current_user?(user)
    end


end
