class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.datetime :activities_visit

      t.timestamps
    end
  end
end
