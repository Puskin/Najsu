class AddFacebookAvatarToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :facebook_avatar, :string

  end
end
