class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :total_todos, :total_reminders, :unit_reminders


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
  CompTodo.all.each do |c|
    if ! Todo.find(c.todo_id).done
      @total_todos += 1
    end
  
  end
  UnitTodo.all.each do |u|
    if ! Todo.find(u.todo_id).done
      @total_todos += 1
    end
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


def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
helper_method :current_user

def authorize
  redirect_to login_url if current_user.nil?
  end

end
