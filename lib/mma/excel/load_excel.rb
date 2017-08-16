

module MMA
  module Excel
    class LoadExcel

      attr_reader :wb, :sheet, :row_arr

      def initialize( f ) #= File.new( "/Users/bleadholm/Downloads/BenStage1\\ February\\ 20.xlsx" ) )
          instantiate_workbook( f )
          @sheet = data_sheet( @wb )
          @row_arr = row_array( @sheet )
      end

      def instantiate_workbook( obj )
        begin
          if obj.is_a?(String)
            f = File.new( obj )
            extension = f.path.split('.')[-1].downcase
            @wb = Roo::Spreadsheet.open( f, extension: extension.to_sym )
          elsif obj.is_a?(File)
            Rails.logger.info "obj is a file #{obj}"
            extension = obj.path.split('.')[-1].downcase
            @wb = Roo::Spreadsheet.open( f, extension: extension.to_sym )
            Rails.logger.info "succeffully opened #{extension == 'xls' ? 'old-school XLS' : 'XLSX'} workbook"
            # if obj.path.split('.')[-1].downcase == 'xlsx'
            #   @wb = Roo::Spreadsheet.open( obj )
            #   Rails.logger.info 'succeffully opened XLSX workbook'
            # elsif obj.path.split('.')[-1].downcase == 'xls'
            #   @wb = Spreadsheet.open( obj )
            #   Rails.logger.info 'succeffully opened old-school XLS workbook'
            # end
          end
        rescue Exception=>ex
          Rails.logger.error( "Couldn't load workbook from #{obj}" )
        end
      end

      def data_sheet( wb_obj )
        begin
          sheet_name = wb_obj.sheets.select{|x| /Data/.match( x )}.first
          wb_obj.sheet( sheet_name ) if sheet_name
        rescue

        end
      end

      def row_array( sheet )
        out_arr = []
        if sheet
          (sheet.first_row..sheet.last_row).each do |row_num|
            arr = sheet.row( row_num )
            out_arr << eval( arr.to_s )
          end
        end
        out_arr
      end
    end
  end
end
