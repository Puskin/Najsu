class AddOwnToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :own, :boolean, :default => false, :null => false

  end
end
