module MMA   # MMA::Banks::WellsFargo::SrpAdjusters::WellsFargoSrpLogic
  module Banks
    module WellsFargo
      module SrpAdjusters

        #f = File.new("/Users/bleadholm/Downloads/FW_BenStage2/Wells\ Sample\ SRP\ Schedule.xlsx")

        class WellsFargoSrpLogic
          # include ClassLevelInheritableAttributes
          # cattr_inheritable :worksheet_rows, :wf_xl

          attr_accessor :worksheet_rows, :wf_xl

          def initialize( object, sheet_number = 0 )
            if object.is_a?(String) && object.index('/')
              object = File.new( object )
            end
            @wf_xl  = MMA::Excel::LoadExcel.new( object ).wb if object.is_a?(File)
            #puts "successfully opened @wf_xl:#{@wf_xl}"        if object.is_a?(File)
            if object && object.is_a?(Array)
              @worksheet_rows   = object
            else
              #puts "About to process sheet_array number:#{sheet_number}"
              @worksheet_rows   = sheet_array( sheet_number )
            end
          end

          def sheet_array( sheet_num = 0 )
            @worksheet_rows ||= begin
              out = []
              #puts "tabs are #{@wf_xl.sheets}"
              sheet = @wf_xl.sheet(sheet_num.to_i)
              (sheet.first_row..sheet.last_row).each do |row_num|
                arr = sheet.row( row_num )
                out << eval( arr.to_s )
              end
              out
            rescue Exception=>e
              Rails.logger.warn "Exception while serializing sheet rows:#{e.message} in WellsFargoSrpLogic"
            end
          end
        end
      end
    end
  end
end
