

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
            @wb = Roo::Spreadsheet.open( f )
          elsif obj.is_a?(File)
            Rails.logger.info "obj is a file #{obj}"
            @wb = Roo::Spreadsheet.open( obj )
            Rails.logger.info 'succeffully opened workbook'
          end
        rescue Exception=>ex
          Rails.logger.error( "Couldn't load workbook from #{obj}" )
        end
      end

      def data_sheet( wb_obj )
        sheet_name = wb_obj.sheets.select{|x| /Data/.match( x )}.first
        wb_obj.sheet( sheet_name )
      end

      def row_array( sheet )
        out_arr = []
        (sheet.first_row..sheet.last_row).each do |row_num|
          arr = sheet.row( row_num )
          out_arr << arr
        end
        out_arr
      end
    end
  end
end
