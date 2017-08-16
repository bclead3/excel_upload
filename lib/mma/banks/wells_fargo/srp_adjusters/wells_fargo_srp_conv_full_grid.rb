module MMA   # MMA::Banks::WellsFargo::SrpAdjusters::WellsFargoSrpConvFullGrid
  module Banks
    module WellsFargo
      module SrpAdjusters

        CONV_FULL_GRID_SHEET_INDEX = 0
        f = File.new("/Users/bleadholm/Downloads/FW_BenStage2/Wells\ Sample\ SRP\ Schedule.xlsx")

        class WellsFargoSrpConvFullGrid < WellsFargoSrpLogic

          attr_accessor :conv_full_grid_rows, :worksheet_rows

          def initialize( obj, sheet_number = CONV_FULL_GRID_SHEET_INDEX )
            super( obj, sheet_number )
          end

          def wf_conv_full_grid_rows
            @conv_full_grid_rows ||= @worksheet_rows ||= sheet_array( CONV_FULL_GRID_SHEET_INDEX )
          end
        end
      end
    end
  end
end
