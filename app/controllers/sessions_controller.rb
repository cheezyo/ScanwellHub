class SessionsController < ApplicationController
  def create
  user = User.find_by_email(params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to units_path, :notice => "Logged in as " + current_user.first_name
  else
    
    redirect_to "/login", :notice => "Please try again"
  end
end
def new

end
def destroy
  session[:user_id] = nil
  redirect_to units_path, :notice => "Logged out"
end
  
  
end
