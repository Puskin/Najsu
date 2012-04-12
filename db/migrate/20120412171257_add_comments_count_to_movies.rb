class AddCommentsCountToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :comments_count, :integer, :default => 0
    Movie.reset_column_information
  	Movie.find(:all).each do |p|
    	Movie.update_counters p.id, :comments_count => p.comments.length
 	 	end
  end
end
