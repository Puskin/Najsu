class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :movie_id
      t.integer :character
      t.integer :user_id

      t.timestamps
    end
  end
end
