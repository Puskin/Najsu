class AddResourceIdToReposts < ActiveRecord::Migration
  def change
    add_column :reposts, :resource_id, :string

  end
end
