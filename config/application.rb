require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module RegisterTest2
  class Application < Rails::Application
      
    #live
    #STATUS_IN_TRANSIT = 3 
    #LOCATION_SCANWELL_NO = 1 
    
    #dev
    STATUS_IN_TRANSIT = 2 
    LOCATION_SCANWELL_NO = 5
    
    
    

  end
end
