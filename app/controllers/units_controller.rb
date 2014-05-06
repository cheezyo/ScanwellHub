class UnitsController < ApplicationController
  before_action :set_unit, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction, :setup_new_registration_for_tracking, :get_by_status_id, :check_comp_calibration
  # GET /units
  # GET /units.json
  def index
   #get_by_status_id
    @unitnames = UnitName.count
    @units = Unit.all
    
    #lms = UnitName.where("title == ? ", "LMS")
    #@lms = Unit.where("unit_name_id == ?", lms)
    
    respond_to do |format|
    format.html
    format.csv { send_data @units.to_csv }
    format.xls 
  end
  end

  # GET /units/1
  # GET /units/1.json
  def show
  end

  # GET /units/new
  def new
    if Company.all.empty?
      redirect_to new_company_path, alert: "You need to create a company before creating a unit."
    end
    @unit = Unit.new
  end

  # GET /units/1/edit
  def edit
  end

  # POST /units
  # POST /units.json
  def create
    @unit = Unit.new(unit_params)
    
    respond_to do |format|
      if @unit.save
        format.html { redirect_to @unit, notice: 'Unit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @unit }
      else
        format.html { render action: 'new' }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    respond_to do |format|
      if @unit.update(unit_params)
      
        format.html { redirect_to @unit, notice: 'Unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    @unit.components.each do |c|
      c.update_attributes(:available => true)
    end   
    @unit.destroy
    
    
    respond_to do |format|
      format.html { redirect_to units_url, notice: "Unit was deleted." }
      format.json { head :no_content }
    end
  end

  private
  
   def check_comp_calibration(unit)
   alert = 0
   
   unit.components.each do |c|
     if (c.last_check + 1.year) <= DateTime.now + 30.days
       alert = alert + 1
       
     end
     
   end
   return alert
   
 end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
      @old_unit = Unit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.require(:unit).permit(:unit_id, :unit_name_id, :location, :last_check, :available, :comment,:company_id, :tracking_id, :client_id)
    end
      
  def sort_column
    Unit.column_names.include?(params[:sort]) ? params[:sort] : "last_check"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
  def get_by_status_id 
     if(params[:owner] != "" && params[:owner] != nil && Company.exists?(params[:owner]))
       @owner = Company.find(params[:owner])
       @owner_id = @owner.id
       units = Unit.where("company_id = ?", params[:owner]).order("last_check asc")
     else
     
     units = Unit.order("last_check asc")
     end
     @units = Array.new
     
    if (params[:status_id] != "" && params[:status_id] != nil && Status.exists?(params[:status_id]))
          
      @status = params[:status_id]
      @status_name = Status.find(params[:status_id]).name
      #units = Unit.all
      #@units = Array.new
      units.each do |u|
       if u.logunits.last.status == @status.to_i
         @units << u
        end
      end
      
    else 
      @units = units
    end
  end
end
