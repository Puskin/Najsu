class AddRepostsCountToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :reposts_count, :integer, :default => 0

  end
end
