class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :resource_id

      t.timestamps
    end
  end
end
