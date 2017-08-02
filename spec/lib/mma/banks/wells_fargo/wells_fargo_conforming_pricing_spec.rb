require 'rails_helper'
require_relative 'wells_fargo_spec_helpers'


module MMA
  module Banks
    module WellsFargo
      # class Wrapper
      #   include WellsFargoLogic
      #
      #   def model
      #     ::MMA::Banks::WellsFargo
      #   end
      # end

      describe WellsFargoConformingPricing, '#conforming_pricing_array' do
        include RSpec::WellsFargoSpecHelpers
        let(:rows) { arr }
        before(:each) do
          @mma_wf = MMA::Banks::WellsFargo::WellsFargoConformingPricing.new( arr )
        end

        it '#conforming_pricing_array should spit out an array of 113 elements' do
          puts "mma_wf:#{@mma_wf.inspect}"
          expect(@mma_wf.wf_conforming_pricing_array).to be_a(Array)
          expect(@mma_wf.wf_conforming_pricing_array.count).to eq(113)
        end

        it '#conforming_pricing_array should show its first sub component is an array' do
          #@mma_wf = setup_parse_logic
          expect(@mma_wf.wf_conforming_pricing_array.first).to be_a(Array)
          expect(@mma_wf.wf_conforming_pricing_array.first).to eq([nil, 'CORRESPONDENT BEST EFFORT CONFORMING PRICING', nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil])
        end

        it '#wf_conforming_date' do
          expect(@mma_wf.wf_conforming_date).to be_a(String)
          expect(@mma_wf.wf_conforming_date).to eq('2017-05-11')
        end

        it '#wf_conforming_price_code' do
          expect(@mma_wf.wf_conforming_price_code).to be_a(String)
          expect(@mma_wf.wf_conforming_price_code).to eq('15966')
        end

        it '#wf_conforming_effective_time' do
          expect(@mma_wf.wf_conforming_effective_time).to be_a(String)
          expect(@mma_wf.wf_conforming_effective_time).to eq('08:00 AM CT')
        end

        it '#wf_conforming_expiration_dates' do
          expect(@mma_wf.wf_conforming_expiration_dates).to eq({:seven_day=>"2017-05-18", :thirty_day=>"2017-06-12", :fourty_five_day=>"2017-06-26", :sixty_day=>"2017-07-10", :seventy_day=>"N/A", :seventy_five_day=>"2017-07-25"})
        end

        it '#wf_conforming_conf_title_index' do
          expect(@mma_wf.wf_conforming_conf_title_index).to eq(20)
        end
      end
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
