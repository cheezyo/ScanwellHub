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
    #STATUS_IN_TRANSIT = 3 #2 local 3 live
    #STATUS_ON_LAND = 2 #4 local 2 live
    
    #Location for LOG init
    #Location id from LOCATION Database
    #LOCATION_SCANWELL_NO = 1 #4 local 1 live
    
    
    STATUS_IN_TRANSIT = 2 
    
    
   
    LOCATION_SCANWELL_NO = 5
    
    

  end
end
