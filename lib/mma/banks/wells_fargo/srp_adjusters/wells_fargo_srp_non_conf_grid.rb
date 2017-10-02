module MMA   # MMA::Banks::WellsFargo::SrpAdjusters::WellsFargoSrpNonConfGrid
  module Banks
    module WellsFargo
      module SrpAdjusters

        #f = File.new("/Users/bleadholm/Downloads/FW_BenStage2/Wells\ Sample\ SRP\ Schedule.xlsx")

        NON_CONF_GRID_SHEET_INDEX = 2

        class WellsFargoSrpNonConfGrid < WellsFargoSrpLogic

          attr_accessor :non_conf_grid_rows, :worksheet_rows

          def initialize( obj, sheet_number = NON_CONF_GRID_SHEET_INDEX )
            super( obj, sheet_number )
          end

          def wf_non_conf_grid_rows
            @non_conf_grid_rows ||= @worksheet_rows ||= sheet_array( NON_CONF_GRID_SHEET_INDEX )
          end
        end
      end
    end
  end
end
