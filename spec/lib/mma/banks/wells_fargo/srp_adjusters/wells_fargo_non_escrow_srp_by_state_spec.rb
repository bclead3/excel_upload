require 'rails_helper'

module MMA
  module Banks
    module WellsFargo
      module SrpAdjusters
        describe WellsFargoNonEscrowSrpByState do
          let(:hash)    { WELLS_FARGO_NON_ESCROW_SRP_HASH }
          let(:subject) { described_class.new }

          it 'has hash' do
            expect(hash).to be_a(Hash)
          end
        end
      end
    end
  end
end
