require 'rails_helper'
require_relative '../wells_fargo/rate_sheet/wells_fargo_spec_helpers'


module MMA
  module Banks
    module Utils
      describe Adjusters do
        it '.calculate_adjusters' do
          MMA::Loan.each do |loan|
            calculate_adjusters( loan )
          end
        end
      end
    end
  end
end
