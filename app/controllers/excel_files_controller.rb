class ExcelFilesController < ApplicationController
  before_action :set_excel_file, only: [:show, :edit, :update, :destroy, :process_file]

  FNMA_15_TYPE_ARRAY = ['10/1 Conventio', 'Conf Fixed 10', 'Conf Fixed 15', 'FNMA Fixed 10', 'FNMA Fixed 15']
  FNMA_30_TYPE_ARRAY = ['Conf Fixed 20', 'Conf Fixed 25', 'Conf Fixed 30', 'Conf FNMA Fixe', 'Conforming Fix', 'DU Refi Plus I', 'FHLMC Conf Fix', 'FNMA Fixed 20', 'FNMA Fixed 25', 'FNMA Fixed 30']
  GNMA_15_TYPE_ARRAY = ['FHA Fixed 15', 'FHA Fixed 15 G']
  GNMA_30_TYPE_ARRAY = ['VA IRRRL Fixed', 'VA Fixed 30', 'FHA Fixed 20', 'FHA Fixed 25','FHA Fixed 30', 'FHA Fixed 30 G', 'VA Fixed 30 GN', 'FHA GNMA II Fi', 'FHA Streamline']
  NON_CONFORMING_ARR = ['MHFA Conventio', 'GRH Fixed 30', 'Non-Agency Ful', 'MHFA 2nd - Mon', 'MHFA FHA Fixed']

  # GET /excel_files
  # GET /excel_files.json
  def index
    @excel_files = ExcelFile.all
  end

  # GET /excel_files/1
  # GET /excel_files/1.json
  def show
  end

  # GET /excel_files/new
  def new
    @excel_file = ExcelFile.new
  end

  # GET /excel_files/1/edit
  def edit
  end

  # POST /excel_files
  # POST /excel_files.json
  def create
    @excel_file = ExcelFile.new(excel_file_params)

    respond_to do |format|
      if @excel_file.save
        format.html { redirect_to @excel_file, notice: 'Excel file was successfully created.' }
        format.json { render :show, status: :created, location: @excel_file }
      else
        format.html { render :new }
        format.json { render json: @excel_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /excel_files/1
  # PATCH/PUT /excel_files/1.json
  def update
    respond_to do |format|
      puts 'in ExcelFile update'
      puts "params:#{excel_file_params}"
      if @excel_file.update(excel_file_params)
        format.html { redirect_to @excel_file, notice: 'Excel file was successfully updated.' }
        format.json { render :show, status: :ok, location: @excel_file }
      else
        @excel_file.update_attribute('name', excel_file_params['name'])
        format.html { render :edit }
        format.json { render json: @excel_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /excel_files/1
  # DELETE /excel_files/1.json
  def destroy
    @excel_file.destroy
    respond_to do |format|
      format.html { redirect_to excel_files_url, notice: 'Excel file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def process_file
    if @excel_file &&
        @excel_file.xl &&
        @excel_file.xl.file &&
        @excel_file.xl.file.file
      begin
      file = File.new( @excel_file.xl.file.file )
      Rails.logger.info("Processing file:#{file.inspect}")
      if file
        loader = MMA::Excel::LoadExcel.new( @excel_file.xl.file.file )
        row_arr = loader.row_arr
      else
        row_arr = []
      end
      rescue Exception => ex
        Rails.logger.warn("Exception when trying to use file:#{ex.message}")
        row_arr = []
      end
    else
      Rails.logger.warn( 'no file found, will process with empty array')
      row_arr = []
    end
    MMA::Excel::ParseExcel.process_array( row_arr )
  end

  def fnma_type
    if Loan.count > 0
      @fnma_15_ls   = Loan.where("loan_program IN ('#{FNMA_15_TYPE_ARRAY.join("','")}')").order(:loan_program)
      @fnma_15_opn  = @fnma_15_ls.select{|loan| ! loan.is_closed }
      @fnma_15_clsd = @fnma_15_ls.select{|loan| loan.is_closed }
      @fnma_loans   = Loan.where("loan_program IN ('#{FNMA_30_TYPE_ARRAY.join("','")}')").order(:loan_program)
      @fnma_open    = @fnma_loans.select{|loan| ! loan.is_closed }
      @fnma_closed  = @fnma_loans.select{|loan| loan.is_closed }
    end
  end

  def gnma_type
    if Loan.count > 0
      @gnma_15_ls = Loan.where("loan_program IN ('#{GNMA_15_TYPE_ARRAY.join("','")}')").order(:loan_program)
      @gnma_loans = Loan.where("loan_program IN ('#{GNMA_30_TYPE_ARRAY.join("','")}')").order(:loan_program)
    end
  end

  def non_conforming_type
    if Loan.count > 0
      @non_conforming_loans = Loan.where("loan_program IN ('#{NON_CONFORMING_ARR.join("','")}')").order(:loan_program)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_excel_file
      file_id = params[:id] || params[:excel_file_id]
      @excel_file = ExcelFile.find(file_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def excel_file_params
      params.require(:excel_file).permit(:xl, :description)
    end
end
