module MMA   # MMA::Banks::WellsFargo::SrpAdjusters::WellsFargoSrpGovFullGrid
  module Banks
    module WellsFargo
      module SrpAdjusters

        GOV_FULL_GRID_SHEET_INDEX = 1
        f = File.new("/Users/bleadholm/Downloads/FW_BenStage2/Wells\ Sample\ SRP\ Schedule.xlsx")

        class WellsFargoSrpGovFullGrid < WellsFargoSrpLogic

          attr_accessor :gov_full_grid_rows, :worksheet_rows

          def initialize( obj, sheet_number = GOV_FULL_GRID_SHEET_INDEX )
            super( obj, sheet_number )
          end

          def wf_gov_full_grid_rows
            @gov_full_grid_rows ||= @worksheet_rows ||= sheet_array( GOV_FULL_GRID_SHEET_INDEX )
          end
        end
      end
    end
  end
end
