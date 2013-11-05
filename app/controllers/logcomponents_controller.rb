class LogcomponentsController < ApplicationController
  before_action :set_logcomponent, only: [:show, :edit, :update, :destroy]

  # GET /logcomponents
  # GET /logcomponents.json
  def index
    @logcomponents = Array.new
    if params[:component_id] != nil
      @logcomponents = Component.find(params[:component_id]).logcomponents if Component.exists?(params[:component_id])
    else
     @logcomponents = Logcomponent.all
    end
    
  end

  # GET /logcomponents/1
  # GET /logcomponents/1.json
  def show
  end

  # GET /logcomponents/new
  def new
    @logcomponent = Logcomponent.new
  end

  # GET /logcomponents/1/edit
  def edit
  end

  # POST /logcomponents
  # POST /logcomponents.json
  def create
    @logcomponent = Logcomponent.new(logcomponent_params)

    respond_to do |format|
      if @logcomponent.save
        format.html { redirect_to component_path(@logcomponent.component_id), notice: 'Logcomponent was successfully created.' }
        format.json { render action: 'show', status: :created, location: @logcomponent }
      else
        format.html { render action: 'new' }
        format.json { render json: @logcomponent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logcomponents/1
  # PATCH/PUT /logcomponents/1.json
  def update
    respond_to do |format|
      if @logcomponent.update(logcomponent_params)
        format.html { redirect_to component_path(@logcomponent.component_id), notice: 'Logcomponent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @logcomponent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logcomponents/1
  # DELETE /logcomponents/1.json
  def destroy
    @logcomponent.destroy
    respond_to do |format|
      format.html { redirect_to logcomponents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_logcomponent
      @logcomponent = Logcomponent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def logcomponent_params
      params.require(:logcomponent).permit(:component_id, :send_date, :sent_from, :sent_by, :sent_to, :on_unit, :arrive_date, :recived_by, :status)
    end
end
