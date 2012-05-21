module SettingsHelper

  def store_settings
    cookies[:user_settings] = current_user.setting.to_json
  end

  def current_settings
  	stored_settings = cookies[:user_settings]
		@current_settings = Setting.new.from_json(stored_settings)		 
  end

  def destroy_settings
  	cookies.delete(:user_settings)
  end

end