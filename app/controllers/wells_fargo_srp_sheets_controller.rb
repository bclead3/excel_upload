class WellsFargoSrpSheetsController < ApplicationController
  before_action :set_wells_fargo_srp_sheet, only: [:show, :edit, :update, :destroy]

  # GET /wells_fargo_srp_sheets
  # GET /wells_fargo_srp_sheets.json
  def index
    puts 'within wells_fargo_srp_sheets_controller index method'
    @wells_fargo_srp_sheets = WellsFargoSrpSheet.all
  end

  # GET /wells_fargo_srp_sheets/1
  # GET /wells_fargo_srp_sheets/1.json
  def show
  end

  # GET /wells_fargo_srp_sheets/new
  def new
    puts 'within wells_fargo_srp_sheets_controller new method'
    @wells_fargo_srp_sheet = WellsFargoSrpSheet.new
  end

  # GET /wells_fargo_srp_sheets/1/edit
  def edit
  end

  # POST /wells_fargo_srp_sheets
  # POST /wells_fargo_srp_sheets.json
  def create
    puts "within create method of wells_fargo_srp_sheets with params: #{wells_fargo_srp_sheet_params.inspect}"
    @wells_fargo_srp_sheet = WellsFargoSrpSheet.new(wells_fargo_srp_sheet_params)

    respond_to do |format|
      puts "the format is:#{format}"
      puts 'about to save'
      begin
        if @wells_fargo_srp_sheet.save
          format.html { redirect_to @wells_fargo_srp_sheet, notice: 'Wells fargo srp sheet was successfully created.' }
          format.json { render :show, status: :created, location: @wells_fargo_srp_sheet }
        else
          format.html { render :new }
          format.json { render json: @wells_fargo_srp_sheet.errors, status: :unprocessable_entity }
        end
      rescue Exception=>ex
        puts "Exception in create controller method:#{ex.message}"
        puts ex.backtrace
      end
    end
  end

  # PATCH/PUT /wells_fargo_srp_sheets/1
  # PATCH/PUT /wells_fargo_srp_sheets/1.json
  def update
    Rails.logger.info "within update method of wells_fargo_srp_sheet with params:#{wells_fargo_srp_sheet_params.inspect}"
    respond_to do |format|
      puts "the format is:#{format}"
      puts 'about to update'
      begin
        if @wells_fargo_srp_sheet.update(wells_fargo_srp_sheet_params)
          format.html { redirect_to @wells_fargo_srp_sheet, notice: 'Wells fargo srp sheet was successfully updated.' }
          format.json { render :show, status: :ok, location: @wells_fargo_srp_sheet }
        else
          format.html { render :edit }
          format.json { render json: @wells_fargo_srp_sheet.errors, status: :unprocessable_entity }
        end
      rescue Exception=>ex
        puts "Exception in update controller method:#{ex.message}"
        puts ex.backtrace
      end
    end
  end

  # DELETE /wells_fargo_srp_sheets/1
  # DELETE /wells_fargo_srp_sheets/1.json
  def destroy
    puts 'about to destroy the worksheet'
    @wells_fargo_srp_sheet.destroy
    respond_to do |format|
      format.html { redirect_to wells_fargo_srp_sheets_url, notice: 'Wells Fargo srp sheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wells_fargo_srp_sheet
      @wells_fargo_srp_sheet = WellsFargoSrpSheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wells_fargo_srp_sheet_params
      params.require(:wells_fargo_srp_sheet).permit(:description, :thefile)
    end
end
