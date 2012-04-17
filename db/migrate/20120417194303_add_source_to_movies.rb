class AddSourceToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :source, :integer

  end
end
