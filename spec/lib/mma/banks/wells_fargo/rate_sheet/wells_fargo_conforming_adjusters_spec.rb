require 'rails_helper'
require_relative 'wells_fargo_spec_helpers'


module MMA::Banks::WellsFargo::RateSheet

      describe WellsFargoConformingAdjusters, '#conforming_pricing_array' do
        require 'pp'
        include RSpec::WellsFargoSpecHelpers
        before(:each) do
          @mma_wf_adj = MMA::Banks::WellsFargo::RateSheet::WellsFargoConformingAdjusters.new( RSpec::WellsFargoSpecHelpers.conf_adjuster_arr )
        end

        it '#wf_conforming_adjuster_array should spit out an array of 107 elements' do
          #puts "@mma_wf_adj:#{ @mma_wf_adj.wf_conforming_adjuster_array}"
          expect(@mma_wf_adj.wf_conforming_adjuster_array).to be_a(Array)
          expect(@mma_wf_adj.wf_conforming_adjuster_array.count).to eq(107)
        end

        it '#wf_conf_adj_fixed_investor_index' do
          expect( @mma_wf_adj.wf_conf_adj_fixed_investor_index).to eq(7)
        end

        it '#wf_conforming_adjuster_array should show its first sub component is an array' do
          #@mma_wf_adj = setup_parse_logic
          expect(@mma_wf_adj.wf_conforming_adjuster_array.first).to be_a(Array)
          expect(@mma_wf_adj.wf_conforming_adjuster_array.first).to eq( [" ", "CORRESPONDENT BEST EFFORT CONFORMING PRICE ADJUSTERS", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil] )
        end

        it '#wf_conf_adj_fixed_investor_hash should parse investor fixed rate adjustments' do
          #pp @mma_wf_adj.wf_conf_adj_fixed_investor_hash
          expect(@mma_wf_adj.wf_conf_adj_fixed_investor_hash).to be_a(Hash)
          expect(@mma_wf_adj.wf_conf_adj_fixed_investor_hash['lt_50']['adjustment']).to eq(-2.125)
          expect(@mma_wf_adj.wf_conf_adj_fixed_investor_hash['50_01_to_70']['adjustment']).to eq(-2.125)
          expect(@mma_wf_adj.wf_conf_adj_fixed_investor_hash['70_01_to_75']['adjustment']).to eq(-2.125)
          expect(@mma_wf_adj.wf_conf_adj_fixed_investor_hash['75_01_to_80']['adjustment']).to eq(-3.375)
          expect(@mma_wf_adj.wf_conf_adj_fixed_investor_hash['80_01_to_85']['adjustment']).to eq(-4.125)
          %w[85_01_to_90 90_01_to_95 95_01_to_97 97_01_to_100].each do |temp_category|
            expect(@mma_wf_adj.wf_conf_adj_fixed_investor_hash[temp_category]['adjustment']).to eq('n/a')
          end
        end

        it '#wf_conf_adj_fixed_attached_condo_hash should parse investor fixed rate condo adjustments' do
          expect(@mma_wf_adj.wf_conf_adj_fixed_attached_condo_hash).to be_a(Hash)
          %w[lt_50 50_01_to_70 70_01_to_75].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_fixed_attached_condo_hash[test_category]['adjustment']).to eq(0.0)
          end

          %w[75_01_to_80 80_01_to_85 85_01_to_90 90_01_to_95 95_01_to_97].each do |temp_category|
            expect(@mma_wf_adj.wf_conf_adj_fixed_attached_condo_hash[temp_category]['adjustment']).to eq(-0.75)
          end
          expect(@mma_wf_adj.wf_conf_adj_fixed_attached_condo_hash['97_01_to_100']['adjustment']).to eq('n/a')
        end

        it '#wf_conf_adj_fixed_high_ltv_hash' do
          expect(@mma_wf_adj.wf_conf_adj_fixed_high_ltv_hash).to be_a(Hash)
          %w[lt_50 50_01_to_70 70_01_to_75 75_01_to_80 80_01_to_85 85_01_to_90 90_01_to_95 95_01_to_97 97_01_to_100].each do |test_category|
            if test_category == '95_01_to_97'
              expect(@mma_wf_adj.wf_conf_adj_fixed_high_ltv_hash[test_category]['adjustment']).to eq(0.0)
            else
              expect(@mma_wf_adj.wf_conf_adj_fixed_high_ltv_hash[test_category]['adjustment']).to eq('n/a')
            end
          end
        end

        it '#wf_conf_adj_fixed_and_arm_2_unit_property_hash' do
          expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_2_unit_property_hash).to be_a(Hash)
          %w[lt_50 50_01_to_70 70_01_to_75 75_01_to_80 80_01_to_85].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_2_unit_property_hash[test_category]['adjustment']).to eq(-1.0)
          end
          %w[85_01_to_90 90_01_to_95 95_01_to_97 97_01_to_100].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_2_unit_property_hash[test_category]['adjustment']).to eq('n/a')
          end
        end

        it '#wf_conf_adj_fixed_and_arm_3_4_unit_property_hash' do
          expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_3_4_unit_property_hash).to be_a(Hash)

          %w[lt_50 50_01_to_70 70_01_to_75 75_01_to_80].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_3_4_unit_property_hash[test_category]['adjustment']).to eq(-1.0)
          end
          %w[80_01_to_85 85_01_to_90 90_01_to_95 95_01_to_97 97_01_to_100].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_3_4_unit_property_hash[test_category]['adjustment']).to eq('n/a')
          end
        end

        it '#wf_conf_adj_fixed_and_arm_coop_hash' do
          expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_coop_hash).to be_a(Hash)

          %w[lt_50 50_01_to_70 70_01_to_75 75_01_to_80 80_01_to_85 85_01_to_90 90_01_to_95].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_coop_hash[test_category]['adjustment']).to eq(-0.25)
          end
          %w[95_01_to_97 97_01_to_100].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_coop_hash[test_category]['adjustment']).to eq('n/a')
          end
        end

        it '#wf_conf_adj_arm_investor_hash' do
          expect(@mma_wf_adj.wf_conf_adj_arm_investor_hash).to be_a(Hash)

          %w[lt_50 50_01_to_70 70_01_to_75].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_arm_investor_hash[test_category]['adjustment']).to eq(-2.125)
          end

          expect(@mma_wf_adj.wf_conf_adj_arm_investor_hash['75_01_to_80']['adjustment']).to eq(-3.375)
          expect(@mma_wf_adj.wf_conf_adj_arm_investor_hash['80_01_to_85']['adjustment']).to eq(-4.125)

          %w[85_01_to_90 90_01_to_95 95_01_to_97 97_01_to_100].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_arm_investor_hash[test_category]['adjustment']).to eq('n/a')
          end
        end

        it '#wf_conf_adj_arm_attached_condos_hash' do
          expect(@mma_wf_adj.wf_conf_adj_arm_attached_condos_hash).to be_a(Hash)

          %w[lt_50 50_01_to_70 70_01_to_75].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_arm_attached_condos_hash[test_category]['adjustment']).to eq(0.0)
          end

          %w[75_01_to_80 80_01_to_85 85_01_to_90 90_01_to_95].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_arm_attached_condos_hash[test_category]['adjustment']).to eq(-0.75)
          end

          %w[95_01_to_97 97_01_to_100].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_arm_attached_condos_hash[test_category]['adjustment']).to eq('n/a')
          end
        end

        it '#wf_conf_adj_arm_ltv_gt_90_lt_95_w_lp_hash' do
          expect(@mma_wf_adj.wf_conf_adj_arm_ltv_gt_90_lt_95_w_lp_hash).to be_a(Hash)

          %w[lt_50 50_01_to_70 70_01_to_75 75_01_to_80 80_01_to_85 85_01_to_90].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_arm_ltv_gt_90_lt_95_w_lp_hash[test_category]['adjustment']).to eq(0.0)
          end

          expect(@mma_wf_adj.wf_conf_adj_arm_ltv_gt_90_lt_95_w_lp_hash['90_01_to_95']['adjustment']).to eq(-0.25)

          %w[95_01_to_97 97_01_to_100].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_arm_ltv_gt_90_lt_95_w_lp_hash[test_category]['adjustment']).to eq('n/a')
          end
        end

        it '#wf_conf_adj_fixed_and_arm_ltv_gt_90_hash' do
          expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_ltv_gt_90_hash).to be_a(Hash)

          %w[lt_50 50_01_to_70 70_01_to_75 75_01_to_80 80_01_to_85 85_01_to_90].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_ltv_gt_90_hash[test_category]['adjustment']).to eq(0.0)
          end

          expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_ltv_gt_90_hash['90_01_to_95']['adjustment']).to eq(-0.125)
          expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_ltv_gt_90_hash['95_01_to_97']['adjustment']).to eq(-0.125)
          expect(@mma_wf_adj.wf_conf_adj_fixed_and_arm_ltv_gt_90_hash['97_01_to_100']['adjustment']).to eq('n/a')
        end

        it '#wf_conf_adj_interest_only_hash' do
          expect(@mma_wf_adj.wf_conf_adj_interest_only_hash).to be_a(Hash)

          %w[lt_50 50_01_to_70 70_01_to_75 75_01_to_80 80_01_to_85 85_01_to_90 90_01_to_95 95_01_to_97 97_01_to_100].each do |test_category|
            expect(@mma_wf_adj.wf_conf_adj_interest_only_hash[test_category]['adjustment']).to eq('n/a')
          end
        end

        it '#wf_conf_adj_secondary_financing_hash' do
          require 'pp'
          #expect(@mma_wf_adj.wf_conf_adj_secondary_financing).to be_a(Hash)
pp @mma_wf_adj.wf_conf_adj_secondary_financing_hash
          # %w[ltv_lte_75 ltv_lte_65 ltv_gt_65_lte_75 ltv_gt_75_lte_90 ltv_gt_75_lte_95 ltv_lte_95].each do |test_category|
          #   puts test_category
          #   puts @mma_wf_adj.wf_conf_adj_secondary_financing[test_category]['fico_lt_720']
          #   puts @mma_wf_adj.wf_conf_adj_secondary_financing[test_category]['fico_gte_720']
          # end
        end

        it '#wf_conf_adj_ltv_fico_all_products_hash' do
pp @mma_wf_adj.wf_conf_adj_ltv_fico_all_products_hash
        end

        it '#wf_conf_adj_ltv_fico_cash_out_hash' do
          pp @mma_wf_adj.wf_conf_adj_ltv_fico_cash_out_hash
        end

      end
end


#wf_obj = MMA::Banks::WellsFargo::WellsFargoLogic.new(arr)
# pp wf_obj.wf_conforming_category_fixed('30yr')
# pp wf_obj.wf_conforming_category_fixed('20yr')
# test_arr = %w[30yr 20yr 15yr 10yr 30yr_relo]
# test_arr.each do |category|
#
# end
