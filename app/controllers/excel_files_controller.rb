class ExcelFilesController < ApplicationController
  before_action :set_excel_file, only: [:show, :edit, :update, :destroy, :process_file]


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
      if file && file.size > 2000
        loader = MMA::Excel::LoadExcel.new( @excel_file.xl.file.file )
        row_arr = loader.row_arr
        puts 'row_arr'
        puts row_arr
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

  def landing
    @excel_file
    redirect_to '/landing_page'
  end

  def fnma_type
    if MMA::Loan.count > 0
      @wf_price_h   = WellsFargoPriceSheet.last.json
      a_hash = nil
      srp_hash = nil
      @fnma_15_loans= MMA::Loan.where("loan_program IN ('#{MMA::FNMA_15_TYPE_ARRAY.join("','")}')").order(:loan_program)
      @fnma_15_opn  = @fnma_15_loans.select{|loan| ! loan.is_closed }
      @f_15_opn_h   = MMA::Banks::WellsFargo::RegularAdjusters::Adjusters.loan_hash_from_subset( @fnma_15_opn )
      @f_15_opn_h.each do |k,l_h|
        price_h = MMA::Banks::Utils::RateMatcher.new( @wf_price_h, a_hash, srp_hash ).find_rate_price( l_h.stringify_keys )
        puts 'price_h'
        puts price_h
        l_h[:wf_price] = price_h
        @f_15_opn_h[k] = l_h
      end
      puts '@f_15_opn_h'
      puts @f_15_opn_h
      @fnma_15_clsd = @fnma_15_loans.select{|loan| loan.is_closed }
      @f_15_clsd_h  = MMA::Banks::WellsFargo::RegularAdjusters::Adjusters.loan_hash_from_subset( @fnma_15_clsd )
      @f_15_clsd_h.each do |k,l_h|
        price_h = MMA::Banks::Utils::RateMatcher.new( @wf_price_h, a_hash, srp_hash ).find_rate_price( l_h.stringify_keys )
        puts 'price_h'
        puts price_h
        l_h[:wf_price]  = price_h
        @f_15_clsd_h[k] = l_h
      end
      puts '@f_15_clsd_h'
      puts @f_15_clsd_h

      @fnma_loans   = MMA::Loan.where("loan_program IN ('#{MMA::FNMA_30_TYPE_ARRAY.join("','")}')").order(:loan_program)
      @fnma_open    = @fnma_loans.select{|loan| ! loan.is_closed }
      @f_30_opn_h   = MMA::Banks::WellsFargo::RegularAdjusters::Adjusters.loan_hash_from_subset( @fnma_open )
      @f_30_opn_h.each do |k, l_h|
        price_h = MMA::Banks::Utils::RateMatcher.new( @wf_price_h, a_hash, srp_hash ).find_rate_price( l_h.stringify_keys )
        puts 'price_h'
        puts price_h
        l_h[:wf_price] = price_h
        @f_30_opn_h[k] = l_h
      end

      @fnma_closed  = @fnma_loans.select{|loan| loan.is_closed }
      @f_30_clsd_h  = MMA::Banks::WellsFargo::RegularAdjusters::Adjusters.loan_hash_from_subset( @fnma_closed )
      @f_30_clsd_h.each do |k, l_h|
        price_h = MMA::Banks::Utils::RateMatcher.new( @wf_price_h, a_hash, srp_hash ).find_rate_price( l_h.stringify_keys )
        puts 'price_h'
        puts price_h
        l_h[:wf_price] = price_h
        @f_30_clsd_h[k] = l_h
      end
    end
  end

  def gnma_type
    if MMA::Loan.count > 0
      @gnma_15_ls = MMA::Loan.where("loan_program IN ('#{MMA::GNMA_15_TYPE_ARRAY.join("','")}')").order(:loan_program)
      @gnma_15_opn  = @gnma_15_ls.select{|loan| ! loan.is_closed }
      @gnma_15_clsd = @gnma_15_ls.select{|loan| loan.is_closed }
      @gnma_loans = MMA::Loan.where("loan_program IN ('#{MMA::GNMA_30_TYPE_ARRAY.join("','")}')").order(:loan_program)
      @gnma_open    = @gnma_loans.select{|loan| ! loan.is_closed }
      @gnma_closed  = @gnma_loans.select{|loan| loan.is_closed }
    end
  end

  def non_conforming_type
    if MMA::Loan.count > 0
      @non_conforming_loans = MMA::Loan.where("loan_program IN ('#{MMA::NON_CONFORMING_ARR.join("','")}')").order(:loan_program)
      @non_conf_open    = @non_conforming_loans.select{|loan| ! loan.is_closed }
      @non_conf_closed  = @non_conforming_loans.select{|loan| loan.is_closed }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_excel_file
      file_id = params[:id] || params[:excel_file_id]
      if file_id == 'landing_page'
        @excel_file = ExcelFile.last
      else
        @excel_file = ExcelFile.find(file_id)
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def excel_file_params
      params.require(:excel_file).permit(:xl, :description)
    end
end
