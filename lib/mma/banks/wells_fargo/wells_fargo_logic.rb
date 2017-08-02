module MMA   #MMA::Banks::WellsFargo::WellsFargoLogic
  module Banks
    module WellsFargo

      f = File.new("/Users/bleadholm/Downloads/Ben\ Stage\ 2\ -\ All\ highly\ confidential/2017.5.11.am.8.00.15966.correspondent.aes.Well.may.11.best.efforts.xls")
      class WellsFargoLogic

        attr_accessor :wf_xl, :rows

        def initialize( object )
          @wf_xl  = MMA::Excel::LoadExcel.new( object ).wb if object.is_a?(File)
          @rows   = object if object.is_a?(Array)
        end

        def sheet_array( sheet_num = 0 )
          @rows ||= begin
            sheet = @wf_xl.worksheets[sheet_num.to_i]
            sheet.each{ |row| @rows << eval( row.to_s ) }
          rescue
          end
        end
      end
    end
  end
end
