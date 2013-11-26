class PagesController < ApplicationController
  def reminders
    date = DateTime.now - 1.year + 31.days
    @units = Unit.where("last_check < ?", date)
    
    @components = Component.where("last_check < ?", date)
    
  end
  
  def index
   if current_user
   @companies = Company.all
   else
     redirect_to "/login", :alert => "Please log in."
   end
  end
end