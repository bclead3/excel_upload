

module MMA
  module Excel
    class LoadExcel

      attr_reader :wb, :sheet, :row_arr

      def initialize( f ) #= File.new( "/Users/bleadholm/Downloads/BenStage1\\ February\\ 20.xlsx" ) )
        Rails.logger.debug( "about to instantiate_workbook with file:#{f.inspect}" )
        instantiate_workbook( f )
        Rails.logger.debug( 'about to call data_sheet with instantiated workbook' )
        @sheet = data_sheet( @wb )
        Rails.logger.debug( 'about to call row_array from sheet' )
        @row_arr = row_array( @sheet )
      end

      def instantiate_workbook( obj )
        begin
          if obj.is_a?(String)
            f = File.new( obj )
            if f.size > 0
              extension = f.path.split('.')[-1].downcase
              @wb = Roo::Spreadsheet.open( f, extension: extension.to_sym )
              Rails.logger.info "succeffully opened #{extension == 'xls' ? 'old-school XLS' : 'XLSX'} workbook"
              @wb
            end
          elsif obj.is_a?(File)
            if obj.size > 0
              Rails.logger.info "obj is a file #{obj}"
              extension = obj.path.split('.')[-1].downcase
              @wb = Roo::Spreadsheet.open( obj, extension: extension.to_sym )
              Rails.logger.info "succeffully opened #{extension == 'xls' ? 'old-school XLS' : 'XLSX'} workbook"
              @wb
            end
          end
        rescue Exception=>ex
          Rails.logger.error( "Couldn't load workbook from #{obj} #{ex.message}" )
        end
      end

      def data_sheet( wb_obj )
        Rails.logger.debug( "entered LoadExcel instance with #data_sheet" )
        begin
          sheet_name = wb_obj.sheets.select{|x| /Data/.match( x )}.first
          Rails.logger.debug( "The sheet name is:#{sheet_name}" )
          wb_obj.sheet( sheet_name ) if sheet_name
        rescue Exception=>ex
          Rails.logger.warn( "error in #data_sheet #{ex.message}" )
          Rails.logger.warn( "error in #data_sheet #{ex.backtrace}" )
        end
      end

      def row_array( sheet )
        out_arr = []
        if sheet
          (sheet.first_row..sheet.last_row).each do |row_num|
            Rails.logger.debug( "processing row:#{row_num}" )
            arr = sheet.row( row_num )
            Rails.logger.debug( "retrieved array:#{arr}" )
            begin
              out_arr << arr #eval( arr.to_s )
            rescue Exception=>ex
              Rails.logger.warn( "Exception:#{ex} trying to just add array with .to_s" )
              begin
              out_arr << arr.to_s
              rescue Exception=>x
                Rails.logger.warn( "Exception:#{x} trying to just add array as-is" )
                begin
                  out_arr << arr
                rescue Exception=>e
                  Rails.logger.warn( "Exception:#{e} FUGGEDDABOUDITTT" )
                end
              end
            end
          end
        end
        out_arr
      end
    end
  end
end
