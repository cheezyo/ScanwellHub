# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
RegisterTest2::Application.initialize!
config.cache_classes = true
config.serve_static_assets = true
config.assets.compile = true
config.assets.digest = true