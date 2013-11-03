class BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  # GET /Brands
  # GET /Brands.json
  def index
    @brands = Brand.all
  end

  # GET /Brands/1
  # GET /Brands/1.json
  def show
  end

  # GET /Brands/new
  def new
    @brand = Brand.new
  end

  # GET /Brands/1/edit
  def edit
  end

  # POST /Brands
  # POST /Brands.json
  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: 'Brand was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brand }
      else
        format.html { render action: 'new' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Brands/1
  # PATCH/PUT /Brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: 'Brand was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Brands/1
  # DELETE /Brands/1.json
  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brand_params
      params.require(:brand).permit(:name, :total_per_unit)
    end
end
