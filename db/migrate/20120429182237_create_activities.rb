class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :recipient_id
      t.integer :resource
      t.integer :action
      t.text :data

      t.timestamps
    end
  end
end
