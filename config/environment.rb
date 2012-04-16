# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tuduk::Application.initialize!

# Thing to initialize no_www class middleware
Rails::Initializer.run do |config|
  config.middleware.use “NoWWW” if RAILS_ENV == ‘production’
end
