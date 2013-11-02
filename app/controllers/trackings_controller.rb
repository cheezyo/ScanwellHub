class TrackingsController < ApplicationController
  before_action :set_tracking, only: [:show, :edit, :update, :destroy]
  before_action :set_unit, only:[:new]

  # GET /trackings
  # GET /trackings.json
  def index
    if(params[:sort] != nil)
    @trackings = Tracking.where(status_id: Status.where("name = ?",params[:sort]))
    elsif (params[:unit_id] != nil)
    @trackings = Tracking.where(unit_id: params[:unit_id]).order("created_at desc")
    @unit = Unit.where("unit_id = ?", params[:unit_id]).first
    else
    @trackings = Tracking.all.order("created_at desc")
    end 

    respond_to do |format|
    format.html
    format.csv { send_data @trackings.to_csv }
    format.xls 
  end
    
  end

  # GET /trackings/1
  # GET /trackings/1.json
  def show
  end

  # GET /trackings/new
  def new
    @tracking = Tracking.new
   if params[:unit_id] != nil
     @my_unit = Unit.find(params[:unit_id])
     @location = Location.find(@my_unit.location)
     @location_list = Location.find(:all, :conditions => ["id != ?", @location.id])
     @staus_in_transit = Status.find_by_name("In transit")
   end
   if params[:action_name] != nil
     @action = params[:action_name]
   end
   
  end

  # GET /trackings/1/edit
  def edit
  end

  # POST /trackings
  # POST /trackings.json
  def create
    @tracking = Tracking.new(tracking_params)

    respond_to do |format|
      if @tracking.save
        
        unit = Unit.where("unit_id = ?", @tracking.unit_id).first
        unit.tracking_id = @tracking.id
       
        if @tracking.status_id != Status.find_by_name("In transit").id    
        unit.location = @tracking.to 
        end 
         unit.components.each do |c|
          c.location = unit.location
        end
        unit.save
        
        format.html { redirect_to @tracking, notice: 'Tracking was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tracking }
      else
        format.html { redirect_to @tracking, notice: "Cant send unit that is allready in transi" }
        format.json { render json: @tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trackings/1
  # PATCH/PUT /trackings/1.json
  def update
     
    respond_to do |format|
      if @tracking.update(tracking_params)
        format.html { redirect_to @tracking, notice: 'Tracking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trackings/1
  # DELETE /trackings/1.json
  def destroy
   tracking = Tracking.where("unit_id = ?", @tracking.unit_id).order("created_at desc")
   unit = Unit.where("unit_id = ?", @tracking.unit_id).first
   unit.tracking_id = tracking[1].id
   if(tracking[1].action_name == "send")
        unit.location = tracking[1].from 
   else 
        unit.location = tracking[1].to
   end
    unit.save
    @tracking.destroy

    respond_to do |format|
      format.html { redirect_to trackings_url }
      format.json { head :no_content }
    end
  end

  private
  
  def set_unit
     @unit_to_send = @unit
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_tracking
      @tracking = Tracking.find(params[:id])
     
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tracking_params
      params.require(:tracking).permit(:status_id, :unit_id, :comment, :from, :to, :action_name, :user_id)
    end
end
