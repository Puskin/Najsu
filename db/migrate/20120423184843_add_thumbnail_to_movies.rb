class AddThumbnailToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :thumbnail, :string

  end
end
