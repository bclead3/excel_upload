require 'mma/banks/wells_fargo/srp_adjusters/wells_fargo_non_escrow_srp_by_state'

module MMA   # MMA::Banks::WellsFargo::SrpAdjusters::WellsFargoSrpConvFullGrid
  module Banks
    module WellsFargo
      module SrpAdjusters

        CONV_FULL_GRID_SHEET_INDEX  = 0
        FNMA_FHLMC_25_30_YEAR_INDEX = 2
        FNMA_FHLMC_20_YEAR_INDEX    = 67
        FNMA_FHLMC_15_YEAR_INDEX    = 131
        FNMA_FHLMC_10_YEAR_INDEX    = 195
        WF_MINIMUM                  = 20000.00
        WF_CONFORMING_LIMIT         = 450000.00
        BEST_EFFORT_RANGE_ARRAY     = [
            '>= WF_MINIMUM && <=85000.00',
            '>= 85000.01 && <=110000.00' ,
            '>=110000.01 && <=150000.00',
            '>=150000.01 && <=175000.00',
            '>=175000.01 && <=240000.00',
            '>=240000.01 && <=300000.00',
            '>=300000.01 && <=360000.00',
            '>=360000.01 && <=WF_CONFORMING_LIMIT',
            '> WF_CONFORMING_LIMIT'
        ]
        BEST_EFFORT_DEFAULT_COLUMN  = 1
        MANDATORY_RANGE_ARRAY       = [
            '>= WF_MINIMUM && <=85000.00',
            '>= 85000.01 && <=110000.00' ,
            '>=110000.01 && <=150000.00',
            '>=150000.01 && <=175000.00',
            '>=175000.01 && <=240000.00',
            '>=240000.01 && <=300000.00',
            '>=300000.01 && <=360000.00',
            '>=360000.01 && <=WF_CONFORMING_LIMIT',
            '> WF_CONFORMING_LIMIT'
        ]
        MANDATORY_DEFAULT_COLUMN    = 10
        STATE_ROW_OFFSET            = 4


        #f = File.new("/Users/bleadholm/Downloads/FW_BenStage2/Wells\ Sample\ SRP\ Schedule.xlsx")

        class WellsFargoSrpConvFullGrid < WellsFargoSrpLogic

          attr_accessor :conv_full_grid_rows, :worksheet_rows

          def initialize( obj, sheet_number = CONV_FULL_GRID_SHEET_INDEX )
            super( obj, sheet_number )
          end

          def wf_conv_full_grid_rows
            @conv_full_grid_rows ||= @worksheet_rows ||= sheet_array( CONV_FULL_GRID_SHEET_INDEX )
          end

          def fnma_fhlmc_25_30_year_index
            wf_conv_full_grid_rows.each_with_index do |row_arr, idx|
              if row_arr[0] == 'FNMA/FHLMC 25/30 YEAR'
                return idx
              end
            end
            return -1 #FNMA_FHLMC_25_30_YEAR_INDEX
          end

          def fnma_fhlmc_20_year_index
            wf_conv_full_grid_rows.each_with_index do |row_arr, idx|
              if row_arr[0] == 'FNMA/FHLMC 20 YEAR'
                return idx
              end
            end
            return -1 #FNMA_FHLMC_20_YEAR_INDEX
          end

          def fnma_fhlmc_15_year_index
            wf_conv_full_grid_rows.each_with_index do |row_arr, idx|
              if row_arr[0] == 'FNMA/FHLMC 15 YEAR'
                return idx
              end
            end
            return -1 #FNMA_FHLMC_15_YEAR_INDEX
          end

          def fnma_fhlmc_10_year_index
            wf_conv_full_grid_rows.each_with_index do |row_arr, idx|
              if row_arr[0] == 'FNMA/FHLMC 10 YEAR'
                return idx
              end
            end
            return -1 #FNMA_FHLMC_10_YEAR_INDEX
          end

          def best_effort_index_from_amount( amount )
            if amount.is_a?(Numeric)
              ret_val = -1
              BEST_EFFORT_RANGE_ARRAY.each_with_index do |range_string, idx|
                if range_string.index('&&')
                  if eval("#{amount}#{range_string.split('&&')[0]}") &&
                      eval("#{amount}#{range_string.split('&&')[0]}")
                    ret_val = BEST_EFFORT_DEFAULT_COLUMN + idx
                  end
                else
                  if eval("#{amount}#{range_string}")
                    ret_val = BEST_EFFORT_DEFAULT_COLUMN + idx
                  end
                end
              end
              ret_val
            end
          end

          def mandatory_index_from_amount( amount )
            if amount.is_a?(Numeric)
              ret_val = -1
              MANDATORY_RANGE_ARRAY.each_with_index do |range_string, idx|
                if range_string.index('&&')
                  if eval("#{amount}#{range_string.split('&&')[0]}") &&
                      eval("#{amount}#{range_string.split('&&')[0]}")
                    ret_val = MANDATORY_DEFAULT_COLUMN + idx
                  end
                else
                  if eval("#{amount}#{range_string}")
                    ret_val = MANDATORY_DEFAULT_COLUMN + idx
                  end
                end
              end
              ret_val
            end
          end

          def state_row_index( initial_index, state )
            return_index = initial_index
            if state && MMA::Banks::WellsFargo::SrpAdjusters::WELLS_FARGO_STATE_ARRAY.index( state.upcase )
              return_index += STATE_ROW_OFFSET
              return_index += MMA::Banks::WellsFargo::SrpAdjusters::WELLS_FARGO_STATE_ARRAY.index( state.upcase )
            elsif state && state.index(' - ')
              state_abbr = state.split(' - ')[0]
              return_index += STATE_ROW_OFFSET
              return_index += MMA::Banks::WellsFargo::SrpAdjusters::WELLS_FARGO_STATE_ARRAY.index( state_abbr )
            end
            return_index
          end

          def best_effort_from_amount( amount, state, initial_index = fnma_fhlmc_25_30_year_index )
            amount_index  = best_effort_index_from_amount( amount )
            row_index     = state_row_index( initial_index, state )
            val           = worksheet_rows[ row_index ][ amount_index ]
          end

          def mandatory_from_amount( amount, state, initial_index = fnma_fhlmc_25_30_year_index )
            amount_index  = mandatory_index_from_amount( amount )
            row_index     = state_row_index( initial_index, state )
            val           = worksheet_rows[ row_index ][ amount_index ]
          end
        end
      end
    end
  end
end
