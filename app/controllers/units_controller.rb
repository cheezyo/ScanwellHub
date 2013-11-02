class UnitsController < ApplicationController
  before_action :set_unit, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction, :setup_new_registration_for_tracking, :get_by_status_id
  # GET /units
  # GET /units.json
  def index
   get_by_status_id
    #@units = Unit.all
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
        
        setup_new_registration_for_tracking
        
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
    @unit.destroy
    respond_to do |format|
      format.html { redirect_to units_url }
      format.json { head :no_content }
    end
  end

  private
  
    def setup_new_registration_for_tracking
    tracking = Tracking.new
    tracking.unit_id = @unit.unit_id
    tracking.action_name = "New registration"
    tracking.from = @unit.location
    tracking.to = @unit.location
    status = Status.find_by_name("On land")
    tracking.status_id = status.id
    tracking.save
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
      @old_unit = Unit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.require(:unit).permit(:unit_id, :location, :last_check, :approved, :comment,:company_id, :tracking_id)
    end
      
  def sort_column
    Unit.column_names.include?(params[:sort]) ? params[:sort] : "last_check"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  def get_by_status_id 
     if(params[:owner] != "" && params[:owner] != nil && Company.exists?(params[:owner]))
       @owner = Company.find(params[:owner])
       @owner_id = @owner.id
       units = Unit.where("company_id = ?", params[:owner]).order(sort_column + " " + sort_direction)
     else
     units = Unit.order(sort_column + " " + sort_direction)
     end
     @units = Array.new
    if (params[:status_id] != "" && params[:status_id] != nil && Status.exists?(params[:status_id]))
          
      @status = params[:status_id]
      @status_name = Status.find(params[:status_id]).name
      
      units.each do |u|
        track = Tracking.find(u.tracking_id)
          if(track.status_id == params[:status_id].to_i)
            @units << u
          end
       
      end
    else 
      @units = units
    end
  end
end
