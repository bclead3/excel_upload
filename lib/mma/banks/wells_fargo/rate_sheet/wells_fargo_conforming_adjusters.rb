module MMA   #MMA::Banks::WellsFargo::RateSheet::WellsFargoConformingAdjusters
  module Banks
    module WellsFargo
      module RateSheet
        LTV_Range_Arr   = %w[lt_50 50_01_to_70 70_01_to_75 75_01_to_80 80_01_to_85 85_01_to_90 90_01_to_95 95_01_to_97 97_01_to_100]

        LTV_Range_2_Arr = %w[ltv_lte_60 ltv_60_01_to_70 ltv_70_01_to_75 ltv_75_01_to_80 ltv_80_01_to_85 ltv_85_01_to_90 ltv_90_01_to_95 ltv_asterisk_95_01_to_97 ltv_hash_95_01_to_97]

        FICO_Arr        = %w[gte_740 720_to_739 700_to_719 680_to_699 660_to_679 640_to_659 620_to_639 lt_620]

        class WellsFargoConformingAdjusters < WellsFargoLogic

          attr_accessor :conf_adjusting_rows, :worksheet_rows

          def initialize( obj, sheet_number = 1 )
            super( obj, sheet_number )
          end

          def wf_conforming_adjuster_array
            @conf_adjusting_rows ||= @worksheet_rows
          end

          def wf_conf_adj_fixed_investor_index
            7
          end

          def wf_conf_adj_fixed_investor_hash
            retrieve_hash( 0 )
          end

          def wf_conf_adj_fixed_attached_condo_hash
            retrieve_hash( 1 )
          end

          def wf_conf_adj_fixed_high_ltv_hash
            retrieve_hash( 5 )
          end

          def wf_conf_adj_fixed_and_arm_2_unit_property_hash
            retrieve_hash( 6 )
          end

          def wf_conf_adj_fixed_and_arm_3_4_unit_property_hash
            retrieve_hash( 7 )
          end

          def wf_conf_adj_fixed_and_arm_coop_hash
            retrieve_hash( 8 )
          end

          def wf_conf_adj_arm_investor_hash
            retrieve_hash( 11 )
          end

          def wf_conf_adj_arm_attached_condos_hash
            retrieve_hash( 12 )
          end

          def wf_conf_adj_arm_ltv_gt_90_lt_95_w_lp_hash
            retrieve_hash( 15 )
          end

          def wf_conf_adj_fixed_and_arm_ltv_gt_90_hash
            retrieve_hash( 16 )
          end

          def wf_conf_adj_interest_only_hash
            retrieve_hash( 20 )
          end

          def wf_conf_adj_secondary_financing_hash
            fico_start_index  = 7
            row_default_index = 32
            return_hash = {}
            %w[ltv_lte_75 ltv_lte_65 ltv_gt_65_lte_75 ltv_gt_75_lte_90 ltv_gt_75_lte_95 ltv_lte_95].each_with_index do |category, row_idx|
              row_index = row_default_index + row_idx
              return_hash[category] = {
                  'fico_lt_720' => wf_conforming_adjuster_array[row_index][fico_start_index],
                  'fico_gte_720' => wf_conforming_adjuster_array[row_index][fico_start_index+1]
              }
            end
            return_hash
          end

          def wf_conf_adj_ltv_fico_all_products_hash
            row_default_index = 75
            ltv_start_index = 7
            return_hash = {}
            LTV_Range_2_Arr.each_with_index do |ltv_category, ltv_sub_index|
              return_hash[ltv_category] = {}
              ltv_index = ltv_start_index + ltv_sub_index
              #puts "ltv_index:#{ltv_start_index}+#{ltv_sub_index} = #{ltv_index}"
              FICO_Arr.each_with_index do |fico_category, fico_sub_index|
                fico_index = row_default_index + fico_sub_index
                #puts "fico_index:#{row_default_index}+#{fico_sub_index} = #{fico_index}"
                #puts "wf_conforming_adjuster_array.count:#{wf_conforming_adjuster_array.count}"
                #puts "value of wf_conforming_adjuster_array[#{fico_index}][#{ltv_index}]:#{wf_conforming_adjuster_array[fico_index][ltv_index]}"
                return_hash[ltv_category][fico_category] = wf_conforming_adjuster_array[fico_index][ltv_index]
              end
            end
            return_hash
          end

          def wf_conf_adj_ltv_fico_cash_out_hash
            row_default_index = 84
            ltv_start_index = 7
            return_hash = {}
            LTV_Range_2_Arr.each_with_index do |ltv_category, ltv_sub_index|
              return_hash[ltv_category] = {}
              ltv_index = ltv_start_index + ltv_sub_index
              #puts "ltv_index:#{ltv_start_index}+#{ltv_sub_index} = #{ltv_index}"
              FICO_Arr.each_with_index do |fico_category, fico_sub_index|
                fico_index = row_default_index + fico_sub_index
                #puts "fico_index:#{row_default_index}+#{fico_sub_index} = #{fico_index}"
                #puts "wf_conforming_adjuster_array.count:#{wf_conforming_adjuster_array.count}"
                #puts "value of wf_conforming_adjuster_array[#{fico_index}][#{ltv_index}]:#{wf_conforming_adjuster_array[fico_index][ltv_index]}"
                return_hash[ltv_category][fico_category] = wf_conforming_adjuster_array[fico_index][ltv_index]
              end
            end
            return_hash
          end

          def hashup
            ret_h = {}

            ret_h['fixed_investor'] = wf_conf_adj_fixed_investor_hash
            ret_h['attached_condo'] = wf_conf_adj_fixed_attached_condo_hash
            ret_h['fixed_high_ltv'] = wf_conf_adj_fixed_high_ltv_hash
            ret_h['fixed_n_arm_2_unit']   = wf_conf_adj_fixed_and_arm_2_unit_property_hash
            ret_h['fixed_n_arm_3_4_unit'] = wf_conf_adj_fixed_and_arm_3_4_unit_property_hash
            ret_h['fixed_n_arm_coop']     = wf_conf_adj_fixed_and_arm_coop_hash
            ret_h['arm_investor']         = wf_conf_adj_arm_investor_hash
            ret_h['arm_attached_condos']  = wf_conf_adj_arm_attached_condos_hash
            ret_h['arm_ltv_gt_90_lt_95_w_lp'] = wf_conf_adj_arm_ltv_gt_90_lt_95_w_lp_hash
            ret_h['fixed_n_arm_ltv_gt_90']    = wf_conf_adj_fixed_and_arm_ltv_gt_90_hash
            ret_h['arm_interest_only']        = wf_conf_adj_interest_only_hash
            ret_h['secondary_financing']      = wf_conf_adj_secondary_financing_hash
            ret_h['arm_ltv_fico_all_products']= wf_conf_adj_ltv_fico_all_products_hash
            ret_h['arm_ltv_fico_cash_out']    = wf_conf_adj_ltv_fico_cash_out_hash
            ret_h
          end

          private

          def retrieve_hash( partial_row_index )
            return_hash = {}
            row_index = wf_conf_adj_fixed_investor_index+partial_row_index
            LTV_Range_Arr.each_with_index do |ltv_category, ltv_idx|
              ltv_index = ltv_idx + 7
              begin
              return_hash[ltv_category.to_s] = { 'adjustment' => wf_conforming_adjuster_array[row_index][ltv_index] }
              rescue
              end

            end
            return_hash
          end
        end
      end
    end
  end
end
