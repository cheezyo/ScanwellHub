require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module RegisterTest2
  class Application < Rails::Application
    
    #Status for LOG init 
    #Status id from STATUS Database
    STATUS_IN_TRANSIT = 3
    STATUS_ON_LAND = 2
    
    #Location for LOG init
    #Location id from LOCATION Database
    LOCATION_SCANWELL_NO = 1
    
    

  end
end
