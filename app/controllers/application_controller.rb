class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :total_todos, :total_reminders, :unit_reminders
  
  before_filter :authorize
  
  delegate :allow?, to: :current_permission
  helper_method :allow?
  
  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?


  
private

def unit_reminders
  date = DateTime.now - 1.year + 31.days
  @units_reminders = Unit.where("last_check < ?", date)
end

def component_reminders
  date = DateTime.now - 1.year + 31.days
  @components = Component.where("last_check < ?", date)
end

def total_todos
 
  @total_todos = 0
  if ! Todo.all.empty?
    @total_todos = Todo.where(done: false).count
  end
   @total_todos          
end

def total_reminders
   @total_reminders = 0
  Unit.all.each do |u|
    days = (u.last_check + 1.year)- DateTime.now 
    if days.to_i < 31 
      @total_reminders += 1
    end
  end 
  Component.all.each do |c|
    days = (c.last_check + 1.year)- DateTime.now 
    if days.to_i < 31 
      @total_reminders += 1
    end
  end
  @total_reminders
end
 def current_permission
    @current_permission ||= Permissions.permission_for(current_user)
  end

  def current_resource
    nil
  end

  def authorize
    if current_permission.allow?(params[:controller], params[:action], current_resource)
      current_permission.permit_params! params
    else
      redirect_to root_url, alert: "Not authorized. If you need to do this operation please contact webmaster."
    end
  end

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
  helper_method :current_user



end
