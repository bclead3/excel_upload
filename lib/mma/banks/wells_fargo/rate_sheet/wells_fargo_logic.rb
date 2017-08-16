module MMA   # MMA::Banks::WellsFargo::RateSheet::WellsFargoLogic
  module Banks
    module WellsFargo
      module RateSheet

        f = File.new("/Users/bleadholm/Downloads/Ben\ Stage\ 2\ -\ All\ highly\ confidential/2017.5.11.am.8.00.15966.correspondent.aes.Well.may.11.best.efforts.xls")

        class WellsFargoLogic
          # include ClassLevelInheritableAttributes
          # cattr_inheritable :worksheet_rows, :wf_xl

          attr_accessor :worksheet_rows, :wf_xl

          def initialize( object, sheet_number = 0 )
            @wf_xl  = MMA::Excel::LoadExcel.new( object ).wb if object.is_a?(File)
            if object && object.is_a?(Array)
              @worksheet_rows   = object
            else
              puts "About to process sheet_array number:#{sheet_number}"
              @worksheet_rows   = sheet_array( sheet_number )
            end
          end

          def sheet_array( sheet_num = 0 )
            @worksheet_rows ||= begin
                                  out = []
              sheet = @wf_xl.worksheets[sheet_num.to_i]
              sheet.each{ |row| out << eval( row.to_s ) }
              out
            rescue Exception=>e
              puts "Exception while serializing sheet rows:#{e.message}"
            end
          end
        end
      end
    end
  end
end
