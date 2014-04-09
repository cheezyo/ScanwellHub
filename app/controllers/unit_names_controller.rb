class UnitNamesController < ApplicationController
  before_action :set_unit_name, only: [:show, :edit, :update, :destroy]

  # GET /unit_names
  # GET /unit_names.json
  def index
    @unit_names = UnitName.all
  end

  # GET /unit_names/1
  # GET /unit_names/1.json
  def show
  end

  # GET /unit_names/new
  def new
    @unit_name = UnitName.new
  end

  # GET /unit_names/1/edit
  def edit
  end

  # POST /unit_names
  # POST /unit_names.json
  def create
    @unit_name = UnitName.new(unit_name_params)

    respond_to do |format|
      if @unit_name.save
        format.html { redirect_to @unit_name, notice: 'Unit name was successfully created.' }
        format.json { render action: 'show', status: :created, location: @unit_name }
      else
        format.html { render action: 'new' }
        format.json { render json: @unit_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_names/1
  # PATCH/PUT /unit_names/1.json
  def update
    respond_to do |format|
      if @unit_name.update(unit_name_params)
        format.html { redirect_to @unit_name, notice: 'Unit name was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @unit_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_names/1
  # DELETE /unit_names/1.json
  def destroy
    @unit_name.destroy
    respond_to do |format|
      format.html { redirect_to unit_names_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit_name
      @unit_name = UnitName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_name_params
      params.require(:unit_name).permit(:title, :description)
    end
end
