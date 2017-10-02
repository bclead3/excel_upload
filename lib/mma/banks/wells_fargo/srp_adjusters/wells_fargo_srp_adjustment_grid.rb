module MMA   # MMA::Banks::WellsFargo::SrpAdjusters::WellsFargoSrpAdjustmentGrid
  module Banks
    module WellsFargo
      module SrpAdjusters

        #f = File.new("/Users/bleadholm/Downloads/FW_BenStage2/Wells\ Sample\ SRP\ Schedule.xlsx")

        ADJUSTMENT_GRID_SHEET_INDEX = 3

        class WellsFargoSrpAdjustmentGrid < WellsFargoSrpLogic

          attr_accessor :adjustment_grid_rows, :worksheet_rows

          def initialize( obj, sheet_number = ADJUSTMENT_GRID_SHEET_INDEX )
            super( obj, sheet_number )
          end

          def wf_adjustment_grid_rows
            @adjustment_grid_rows ||= @worksheet_rows ||= sheet_array( ADJUSTMENT_GRID_SHEET_INDEX )
          end
        end
      end
    end
  end
end
