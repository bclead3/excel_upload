class WellsFargoPriceSheetsController < ApplicationController
  before_action :set_wells_fargo_price_sheet, only: [:show, :edit, :update, :destroy]

  # GET /wells_fargo_price_sheets
  # GET /wells_fargo_price_sheets.json
  def index
    puts 'in wells_fargo_price_sheets controller index method'
    begin
      @wells_fargo_price_sheets = WellsFargoPriceSheet.all
    rescue Exception=>ex
      puts "Exception in wf price sheets index controller #{ex.message}"
      puts ex.backtrace
    end
  end

  # GET /wells_fargo_price_sheets/1
  # GET /wells_fargo_price_sheets/1.json
  def show
    @wells_fargo_price_sheet = WellsFargoPriceSheet.find(params['id'] )
  end

  # GET /wells_fargo_price_sheets/new
  def new
    puts 'in wells_fargo_price_sheets controller new method'
    @wells_fargo_price_sheet = WellsFargoPriceSheet.new
  end

  # GET /wells_fargo_price_sheets/1/edit
  def edit
  end

  # POST /wells_fargo_price_sheets
  # POST /wells_fargo_price_sheets.json
  def create
    puts 'in WF Price Sheet create'
    puts "the params are:#{wells_fargo_price_sheet_params}"
    @wells_fargo_price_sheet = WellsFargoPriceSheet.new(wells_fargo_price_sheet_params)

    respond_to do |format|
      if @wells_fargo_price_sheet.save
        format.html { redirect_to @wells_fargo_price_sheet, notice: 'Wells fargo price sheet was successfully created.' }
        format.json { render :show, status: :created, location: @wells_fargo_price_sheet }
      else
        format.html { render :new }
        format.json { render json: @wells_fargo_price_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wells_fargo_price_sheets/1
  # PATCH/PUT /wells_fargo_price_sheets/1.json
  def update
    puts 'in WF Price Sheet update'
    puts "the params are:#{wells_fargo_price_sheet_params}"
    respond_to do |format|
      if @wells_fargo_price_sheet.update(wells_fargo_price_sheet_params)
        format.html { redirect_to @wells_fargo_price_sheet, notice: 'Wells fargo price sheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @wells_fargo_price_sheet }
      else
        format.html { render :edit }
        format.json { render json: @wells_fargo_price_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wells_fargo_price_sheets/1
  # DELETE /wells_fargo_price_sheets/1.json
  def destroy
    puts 'about to destroy the price sheet'
    @wells_fargo_price_sheet.destroy
    respond_to do |format|
      format.html { redirect_to wells_fargo_price_sheets_url, notice: 'Wells fargo price sheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wells_fargo_price_sheet
      @wells_fargo_price_sheet = WellsFargoPriceSheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wells_fargo_price_sheet_params
      params.require(:wells_fargo_price_sheet).permit(:description, :thefile)
    end
end
