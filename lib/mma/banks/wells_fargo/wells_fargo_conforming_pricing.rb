module MMA   # MMA::Banks::WellsFargo::WellsFargoConformingPricing
  module Banks
    module WellsFargo

      class WellsFargoConformingPricing < WellsFargoLogic

        attr_accessor :conf_pricing_rows, :worksheet_rows

        def initialize( obj, sheet_number = 0 )
          super( obj, sheet_number )
        end

        def wf_conforming_pricing_array
          @conf_pricing_rows ||= @worksheet_rows ||= sheet_array( 0 )
        end

        def wf_conforming_date
          (DateTime.new(1899,12,30) + (wf_conforming_pricing_array[2][7] ? wf_conforming_pricing_array[2][7].to_i : 0).days).strftime('%Y-%m-%d')
        end

        def wf_conforming_price_code
          wf_conforming_pricing_array[2][3].to_i.to_s
        end

        def wf_conforming_effective_time
          wf_conforming_pricing_array[2][12]
        end

        def wf_conforming_expiration_dates
          { seven_day:        MMA::Excel::ExcelUtils.parse_to_yyyy_mm_dd( wf_conforming_pricing_array[14][11] ),
            thirty_day:       MMA::Excel::ExcelUtils.parse_to_yyyy_mm_dd( wf_conforming_pricing_array[14][12] ),
            fourty_five_day:  MMA::Excel::ExcelUtils.parse_to_yyyy_mm_dd( wf_conforming_pricing_array[14][13] ),
            sixty_day:        MMA::Excel::ExcelUtils.parse_to_yyyy_mm_dd( wf_conforming_pricing_array[14][14] ),
            seventy_day:      MMA::Excel::ExcelUtils.parse_to_yyyy_mm_dd( wf_conforming_pricing_array[14][15] ),
            seventy_five_day: MMA::Excel::ExcelUtils.parse_to_yyyy_mm_dd( wf_conforming_pricing_array[16][11] )
          }
        end

        def wf_conforming_conf_title_index
          20
        end

        def wf_conforming_category_fixed( category = '30yr')
          cat_array = %w[30yr 20yr 15yr 10yr 30yr_relo]
          cat_index = cat_array.index( category )
          y_index   = 1 + 3*cat_index

          out_hash = {}
          x_index = wf_conforming_conf_title_index + 3
          (x_index..(x_index+25)).each do |row_val|
            row = wf_conforming_pricing_array[row_val]
            unless row[y_index].to_s.blank?
              out_hash[ row[y_index].to_s] = {rate: row[y_index], thirty_day: row[y_index+1], sixty_day: row[y_index+2]}
            end
          end
          out_hash
        end

        def wf_conforming_additional_lock_periods_index
          50
        end

        def wf_conforming_additional_lock_periods
          row_index_arr  = %w[30yr 20yr 15yr 30yr_relo 5_1_libor 7_1_libor 10_1_libor]
          column_index_arr  = %w[7day 15day 45day 70day 75day]
          return_hash = {}
          row_index_arr.each_with_index do |category, cat_idx|
            row_index = wf_conforming_additional_lock_periods_index + cat_idx + 2
            return_hash[category] = {}
            column_index_arr.each_with_index do |day_category, day_part_idx|
              day_index = day_part_idx + 3
              return_hash[category][day_category] = wf_conforming_pricing_array[row_index][day_index]
            end
          end
          return_hash
        end

        def wf_conforming_libor_arm_index
          63
        end

        def wf_conforming_libor_arms
          return_hash = {}
          row_index = wf_conforming_libor_arm_index + 4
          column_index_arr = %w[3_1_libor 5_1_libor 7_1_libor 10_1_libor]
          (row_index..(row_index+25)).each do |row_val|
            row = wf_conforming_pricing_array[row_val]
            unless row.compact.count == 0
              column_index_arr.each_with_index do |category, cat_indx|
                column_index = 1 + cat_indx*3
                return_hash[category] = {} if return_hash[category].nil?
                #puts "category:#{category} column_index:#{column_index} rate:#{row[column_index]} 30day:#{row[column_index+1]} 60day:#{row[column_index+2]}"
                if row[column_index].nil?
                  if category == '3_1_libor'
                    return_hash[category]['rate']  = 'N/A'
                    return_hash[category]['30day'] = 'N/A'
                    return_hash[category]['60day'] = 'N/A'
                  end
                else
                  rate_val = row[column_index].to_s
                  return_hash[category][rate_val] = {}
                  return_hash[category][rate_val]['rate'] = row[column_index]
                  return_hash[category][rate_val]['30day'] = row[column_index+1]
                  return_hash[category][rate_val]['60day'] = row[column_index+2]
                end
              end
            end
          end
          return_hash
        end

        def hashup
          out_hash = {}
          out_hash[:date] = wf_conforming_date
          out_hash[:price_code] = wf_conforming_price_code
          out_hash[:effective_time] = wf_conforming_effective_time
          out_hash[:expiration_dates] = wf_conforming_expiration_dates
          out_hash[:conventional_fixed_rates] = {}
          %w[30yr 20yr 15yr 10yr 30yr_relo].each do |category|
            out_hash[:conventional_fixed_rates][category] = wf_conforming_category_fixed( category )
          end
          out_hash[:additional_lock_periods] = wf_conforming_additional_lock_periods

          out_hash[:conforming_libor_arms]   = wf_conforming_libor_arms
          out_hash
        end

      end
    end
  end
end
