require 'rails_helper'
require_relative 'wells_fargo_spec_helpers'


module MMA
  module Banks
    module WellsFargo

      describe WellsFargoLogic, '#conforming_pricing_array' do
        include RSpec::WellsFargoSpecHelpers
        let(:rows) { arr }
        before(:each) do
          @mma_wf = MMA::Banks::WellsFargo::WellsFargoLogic.new( arr )
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
