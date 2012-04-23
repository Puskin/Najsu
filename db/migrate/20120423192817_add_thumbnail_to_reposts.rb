class AddThumbnailToReposts < ActiveRecord::Migration
  def change
    add_column :reposts, :thumbnail, :string

  end
end
