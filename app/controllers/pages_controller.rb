class PagesController < ApplicationController
  def reminders
    date = DateTime.now - 1.year + 31.days
    @units = Unit.where("last_check < ?", date)
    
    @components = Component.where("last_check < ?", date)
    
  end
  
  def index
    
   @companies = Company.all
  end
end