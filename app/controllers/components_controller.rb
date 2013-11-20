class ComponentsController < ApplicationController
  before_action :set_component, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  # GET /components
  # GET /components.json
  def index
    if(params[:unit_id] != nil && params[:unit_id] && Unit.exists?(params[:unit_id]))
      unit = Unit.find(params[:unit_id])
      @components = unit.components
      @unit_id = unit.unit_id
    elsif(params[:brand_id] != nil && params[:brand_id] != "" && Brand.exists?(params[:brand_id]))
      @components = Component.where("brand_id = ?", params[:brand_id])
    
      if(params[:available] != nil && params[:available] != "")
          @available = params[:available] == "true" ? true : false
          @components = @components.where("available = ?", @available)
      end 
    
     
      @brand = Brand.find(params[:brand_id])
    
    elsif (params[:avilable] != "" && params[:available] != nil)
      @available = params[:available] == "true" ? true : false
      @components = Component.where("available = ?", @available)
      
    else  
      @components = Component.all
    
    end 
  end

  # GET /components/1
  # GET /components/1.json
  def show
  end
  def import
    Component.import(params[:file])
    redirect_to root_url, notice: "Component imported."
  end
  # GET /components/new
  def new
    if Brand.all.empty?
     redirect_to new_brand_path, alert: "You need to create a type of component before creating a component."
     
    elsif Company.all.empty?
      redirect_to new_company_path, alert: "You need to create a company before creating a component."
      
    end
    @component = Component.new
  end

  # GET /components/1/edit
  def edit
  end
  
  def edit_individual
    if params[:component_ids] != nil
      @components = Component.find(params[:component_ids])
    else 
      redirect_to components_url, notice: 'You need to select at least one item to edit'
    end 
  end
  
  def update_individual
    @components = Component.update(params[:components].keys, params[:components].values) 
    @components.reject! { |c| c.errors.empty? }
    if @components.empty?    
      redirect_to components_url, notice: "Components were updated successfully"
    else 
      render "edit_individual"
    end
    
    
  end

  # POST /components
  # POST /components.json
  def create
    @component = Component.new(component_params)

    respond_to do |format|
      if @component.save
        
        format.html { redirect_to @component, notice: 'Component was successfully created.' }
        format.json { render action: 'show', status: :created, location: @component }
      else
        format.html { render action: 'new' }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /components/1
  # PATCH/PUT /components/1.json
  def update
    respond_to do |format|
      if @component.update(component_params)
        format.html { redirect_to @component, notice: 'Component was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # DELETE /components/1
  # DELETE /components/1.json
  def destroy
    @component.destroy
    respond_to do |format|
      format.html { redirect_to components_url, notice: "Component deleted" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component
      @component = Component.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_params
      params.require(:component).permit(:comp_id, :last_check, :unit_id, :brand_id, :available, :calibrated, :commet, :company_id, :component_ids, :components, :range)
    end
    
      def sort_column
    Component.column_names.include?(params[:sort]) ? params[:sort] : "last_check"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
