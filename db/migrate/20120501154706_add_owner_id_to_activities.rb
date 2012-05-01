class AddOwnerIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :owner_id, :integer, :default => 0

  end
end
