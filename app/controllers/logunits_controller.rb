class LogunitsController < ApplicationController
  before_action :set_logunit, only: [:show, :edit, :update, :destroy]
  helper_method :is_in_transit
  # GET /logunits
  # GET /logunits.json
  def index
    @logunits = Array.new
    if params[:unit_id] != nil
      @logunits = Unit.find(params[:unit_id]).logunits.order("created_at desc") if Unit.exists?(params[:unit_id])
    else
      @logunits = Logunit.all.order("created_at desc")
    end
  end

  # GET /logunits/1
  # GET /logunits/1.json
  def show
  end

  # GET /logunits/new
  def new    
      redirect_to root_url, notice: "Sorry no access"  
  end
  

  # GET /logunits/1/edit
  def edit
  end

  # POST /logunits
  # POST /logunits.json
  def create
    @logunit = Logunit.new(logunit_params)
    @logunit.sent_by = current_user.id
    respond_to do |format|
      if @logunit.save
         
         
          unit = Unit.find(@logunit.unit_id)
        #log components
        unit.components.each do |c|
          logcomp = Logcomponent.new
          logcomp.component_id = c.id
          logcomp.send_date = @logunit.send_date
          logcomp.sent_from = @logunit.sent_from
          logcomp.sent_by = @logunit.sent_by
          logcomp.sent_to = @logunit.sent_to       
          logcomp.status = @logunit.status
          logcomp.on_unit = @logunit.unit_id
          logcomp.save
        end
       
        format.html { redirect_to unit_path(unit), notice: 'Unit was successfully sent' }
        format.json { render action: 'show', status: :created, location: @logunit }
      else
        format.html { render action: 'new' }
        format.json { render json: @logunit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logunits/1
  # PATCH/PUT /logunits/1.json
  def update
    respond_to do |format|
      if @logunit.update(logunit_params)
        unit = Unit.find(@logunit.unit_id)
        
        #update component log
        unit.components.each do |c|
          logcomp = c.logcomponents.last
          logcomp.update_attributes(:send_date => @logunit.send_date,:sent_by => @logunit.sent_by, 
          :sent_from => @logunit.sent_from, :sent_to => @logunit.sent_to, :status => @logunit.status,
          :client_id => @logunit.client_id, :arrive_date => @logunit.arrive_date, :recived_by => @logunit.recived_by,
          :package_id => @logunit.package_id)
                    
        end
        
        format.html { redirect_to unit_path(unit), notice: "Log updated" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @logunit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logunits/1
  # DELETE /logunits/1.json
  def destroy
    @logunit.destroy
    respond_to do |format|
      format.html { redirect_to logunits_url }
      format.json { head :no_content }
    end
  end

  private
  
   def is_in_transit
    
    log = @unit.logunits.last
    if(log.arrive_date == nil)
     return false
     else
       return true  
    end
    
    
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_logunit
      @logunit = Logunit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def logunit_params
      params.require(:logunit).permit(:package_id, :unit_id, :send_date, :sent_by, :sent_from, :sent_to, :arrive_date, :recived_by, :status, :logunit_id, :client_id)
    end
end
