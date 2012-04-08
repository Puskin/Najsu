class AddViewsCountToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :views_count, :integer, :default => 0

  end
end
