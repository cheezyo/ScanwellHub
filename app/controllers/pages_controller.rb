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
    
  end
  
  def create_report
 
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
    format.xsl  
    
      end
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