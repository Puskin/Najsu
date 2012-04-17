class AddSourceToReposts < ActiveRecord::Migration
  def change
    add_column :reposts, :source, :integer

  end
end
