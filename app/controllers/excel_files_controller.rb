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
    loader = MMA::Excel::LoadExcel.new( @excel_file.xl.file.file )
    MMA::Excel::ParseExcel.process_array( loader.row_arr )
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
