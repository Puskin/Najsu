class AddActivitiesVisitToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activities_visit, :datetime

  end
end
