class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy, :recive]
  helper_method :update_logs
  # GET /packages
  # GET /packages.json
  def index
    @packages = Package.all
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
  end

  # GET /packages/new
  def new
    
    @package = Package.new
  end
  def recive
    
   status = Location.find(@package.destiantion).status
   @package.update_attributes(:arrival_date => params[:arrival_date], :reciver => params[:reciver], :status => status)
   update_logs(@package,params[:arrival_date], params[:reciver], status)
   redirect_to @package, notice: "Package is checked in."
    
  end
  # GET /packages/1/edit
  def edit
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)
    add_items
    
    respond_to do |format|
      if @package.save
        set_client_id
        format.html { redirect_to @package, notice: 'Package was successfully created.' }
        format.json { render action: 'show', status: :created, location: @package }
      else
        format.html { render action: 'new' }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    respond_to do |format|
      add_items
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'Package was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to packages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end
   def set_client_id
     if @package.unit_ids != nil
      @package.unit_ids.each do |unit|
         u = Unit.find(unit)
         if params[:client_id] != nil
          u.logunits.last.update_attributes(:client_id => params[:client_id])
         else
           u.logunits.last.update_attributes(:client_id => u.logunits[u.logunits.count - 2].client_id)
         end
         if u.components != nil
           u.components.each do |c|
             if params[:client_id] != nil
             c.logcomponents.last.update_attributes(:client_id => params[:client_id])
             else
               c.logcomponents.last.update_attributes(:client_id => c.logcomponents[c.logcomponents.count - 2].client_id)
             end
           end
         end
       end
     end
     
     if @package.components_ids != nil 
       @package.components_ids.each do |c|
          if params[:client_id] != nil
             c.logcomponents.last.update_attributes(:client_id => params[:client_id])
          else
             c.logcomponents.last.update_attributes(:client_id => c.logcomponents[c.logcomponents.count - 2].client_id)
          end
       end
     end
   end
   def update_logs(package, arrival_date, reciver, status)
   
     if package.unit_ids != nil
       package.unit_ids.each do |unit|
         u = Unit.find(unit)
         u.update_attributes(:available => true)
         u.logunits.last.update_attributes(:arrive_date => arrival_date, :recived_by => reciver, :status => status)
         
         if u.components != nil
           u.components.each do |c|
             
             c.logcomponents.last.update_attributes(:arrive_date => arrival_date, :recived_by => reciver, :status => status)
           end
         end
       end
    end
    
    if package.components_ids != nil 
      package.components_ids.each do |comp|
        c = Component.find(comp)
       
        c.update_attributes(:available => true)
        c.logcomponents.last.update_attributes(:arrive_date => arrival_date, :recived_by => reciver, :status => status)
      end
    end
 end
    def add_items
      @package.unit_ids = params[:unit_ids]
      @package.components_ids = params[:components_ids]
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:origin, :destiantion, :arrival_date, :reciver, :status, :po, :ref, :coment, :pack_nr, :unit_ids, :components_ids)
    end
end
