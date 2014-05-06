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
  
  def export
    @log = Array.new
  end
  
  def create_report
 
  end
  def get_unit_location
   @log = Logunit.order("send_date desc ")
     if ! params[:unit_location_start_date].blank?
     date = Date.parse(params[:unit_location_start_date])
     @log = @log.where("send_date >= ?", date)
    end
    if ! params[:unit_location_end_date].blank?
     end_date = Date.parse(params[:unit_location_end_date])
     @log = @log.where("send_date <= ?", end_date)
   end
   if ! params[:sent_from].blank?
     @log = @log.where("sent_from == ?", params[:sent_from])
   end
  
  
     render 'export'
    
  end
  def get_unit_report
    
    @units = Unit.all
    
    @units = @units.where("company_id == ? ", params[:company_id]) if ! params[:company_id].blank?
    
    if ! params[:yearl_check_date].blank?
      date = DateTime.parse(params[:yearl_check_date]).to_date
      date = date - 1.year
      @units = @units.where("last_check <= ?", date )
    end
   
      @units = @units.reject {|u| u.logunits.last.status != params[:status].to_i}  if ! params[:status].blank?

     if @units.empty? 
        redirect_to "/export", notice: "No data to export with you search parameters."
    else
    respond_to do |format|
    format.html
    format.csv { send_data to_csv(@components,@comp_column_names) }
    format.xls  
    
      end
    end 
  end
  
  def get_todo_report
  @unit_todos = Array.new
  UnitTodo.all.each do |ut|
  todo = Todo.find(ut.todo_id)
   if ! todo.done 
      @unit_todos << ut
   end
  end 
  
   @comp_todos = Array.new
  CompTodo.all.each do |ct|
  todo = Todo.find(ct.todo_id)
   if ! todo.done 
      @comp_todos << ct
   end
  end
    respond_to do |format|
    format.html
    #format.csv { send_data to_csv(@components,@comp_column_names) }
    format.xls 
    end  
  end
  
    def to_csv(list,column_names, options = {})
    CSV.generate(options) do |csv|
    csv << column_names
    list.each do |obj|
      csv << obj.attributes.values_at(*column_names)
    end
  end
end
end