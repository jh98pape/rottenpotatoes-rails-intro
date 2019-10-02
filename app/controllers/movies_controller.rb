# Source for sessions: https://www.justinweiss.com/articles/how-rails-sessions-work/
# Source for ||      : https://medium.com/@jaredrayjohnson1/ruby-operators-double-pipe-equals-bfcbe21a7177
class MoviesController < ApplicationController
  #helper_method :sort_column
  #@all_ratings = ['G','PG','PG-13','R']
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #if not defined?(session[:prev_sort])
    # session[:prev_sort] = params[:sort]
    #end
    #session[:prev_sort]=params[:sort]
    session[:prev_sort] = params[:sort] || session[:prev_sort]
    session[:path] = movies_path
    session[:prev_ratings] = params[:ratings] || session[:prev_ratings]
    @all_ratings=Movie.get_ratings()
    @my_ratings=Array.new
    if !session[:prev_ratings].nil?
      session[:prev_ratings].each do |ratng,val|
        @my_ratings << ratng
      end
    end
    #for r in params[:ratings] do
    #  if r.value do
    #    @my_ratings << r.key
    #  end
    #end
    #@movies = Movie.all.order(session[:prev_sort])
    @movies = Movie.where("rating in (?)",@my_ratings).order(session[:prev_sort])

  end

  def new
    # default: render 'new' template
  end

  def create

    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path #+session[:sort]
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
