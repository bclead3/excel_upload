require 'rails_helper'
require_relative 'wells_fargo_srp_spec_helper'


module MMA::Banks::WellsFargo::SrpAdjusters

  # MMA::Banks::WellsFargo::SrpAdjusters::WellsFargoSrpConvFullGrid

  describe WellsFargoSrpConvFullGrid do
    include RSpec::WellsFargoSrpSpecHelpers
    let(:rows) { conv_full_grid_arr }
    let(:subject)  { described_class.new( rows ) }

    it '#worksheet_rows is an array that has 445 rows' do
      expect(subject.worksheet_rows).to be_a(Array)
      expect(subject.worksheet_rows.count).to eq(445)
    end

    it '#fnma_fhlmc_25_30_year_index should be 2' do
      #puts "mma_wf:#{@mma_wf.inspect}"
      expect( subject.fnma_fhlmc_25_30_year_index ).to eq(2)
    end

    it '#fnma_fhlmc_20_year_index should be 67' do
      #puts "mma_wf:#{@mma_wf.inspect}"
      expect( subject.fnma_fhlmc_20_year_index ).to eq(67)
    end

    it '#fnma_fhlmc_15_year_index should be 67' do
      #puts "mma_wf:#{@mma_wf.inspect}"
      expect( subject.fnma_fhlmc_15_year_index ).to eq(131)
    end

    it '#fnma_fhlmc_10_year_index should be 67' do
      #puts "mma_wf:#{@mma_wf.inspect}"
      expect( subject.fnma_fhlmc_10_year_index ).to eq(195)
    end

    # BEST_EFFORT_RANGE_ARRAY     = [
    # '>= WF_MINIMUM && <=85000.00',
    #     '>= 85000.01 && <=110000.00' ,
    #     '>=110000.01 && <=150000.00',
    #     '>=150000.01 && <=175000.00',
    #     '>=175000.01 && <=240000.00',
    #     '>=240000.01 && <=300000.00',
    #     '>=300000.01 && <=360000.00',
    #     '>=360000.01 && <=WF_CONFORMING_LIMIT',
    #     '> WF_CONFORMING_LIMIT'
    # ]
    it '#best_effort_index_from_amount' do
      expect( subject.best_effort_index_from_amount(  40_000 ) ).to eq(1)
      expect( subject.best_effort_index_from_amount(  85_000 ) ).to eq(1)
      expect( subject.best_effort_index_from_amount(  85_000.01 ) ).to eq(2)
      expect( subject.best_effort_index_from_amount( 110_000 ) ).to eq(2)
      expect( subject.best_effort_index_from_amount( 110_000.01 ) ).to eq(3)
      expect( subject.best_effort_index_from_amount( 150_000 ) ).to eq(3)
      expect( subject.best_effort_index_from_amount( 150_000.01 ) ).to eq(4)
      expect( subject.best_effort_index_from_amount( 170_000 ) ).to eq(4)
      expect( subject.best_effort_index_from_amount( 230_000 ) ).to eq(5)
      expect( subject.best_effort_index_from_amount( 240_000.01 ) ).to eq(6)
      expect( subject.best_effort_index_from_amount( 300_000 ) ).to eq(6)
      expect( subject.best_effort_index_from_amount( 300_000.01 ) ).to eq(7)
      expect( subject.best_effort_index_from_amount( 360_000 ) ).to eq(7)
      expect( subject.best_effort_index_from_amount( 360_000.01 ) ).to eq(8)
      expect( subject.best_effort_index_from_amount( 450_000 ) ).to eq(8)
      expect( subject.best_effort_index_from_amount( 450_000.01 ) ).to eq(9)
      expect( subject.best_effort_index_from_amount( 999_000 ) ).to eq(9)
      expect( subject.best_effort_index_from_amount( 2_450_000 ) ).to eq(9)
    end

    it '#mandatory_index_from_amount' do
      expect( subject.mandatory_index_from_amount(  40_000 ) ).to eq(10)
      expect( subject.mandatory_index_from_amount(  85_000 ) ).to eq(10)
      expect( subject.mandatory_index_from_amount(  85_000.01 ) ).to eq(11)
      expect( subject.mandatory_index_from_amount( 110_000 ) ).to eq(11)
      expect( subject.mandatory_index_from_amount( 110_000.01 ) ).to eq(12)
      expect( subject.mandatory_index_from_amount( 150_000 ) ).to eq(12)
      expect( subject.mandatory_index_from_amount( 150_000.01 ) ).to eq(13)
      expect( subject.mandatory_index_from_amount( 170_000 ) ).to eq(13)
      expect( subject.mandatory_index_from_amount( 230_000 ) ).to eq(14)
      expect( subject.mandatory_index_from_amount( 240_000.01 ) ).to eq(15)
      expect( subject.mandatory_index_from_amount( 300_000 ) ).to eq(15)
      expect( subject.mandatory_index_from_amount( 300_000.01 ) ).to eq(16)
      expect( subject.mandatory_index_from_amount( 360_000 ) ).to eq(16)
      expect( subject.mandatory_index_from_amount( 360_000.01 ) ).to eq(17)
      expect( subject.mandatory_index_from_amount( 450_000 ) ).to eq(17)
      expect( subject.mandatory_index_from_amount( 450_000.01 ) ).to eq(18)
      expect( subject.mandatory_index_from_amount( 999_000 ) ).to eq(18)
      expect( subject.mandatory_index_from_amount( 2_450_000 ) ).to eq(18)
    end

    it '#state_row_index' do
      expect( subject.state_row_index( subject.fnma_fhlmc_25_30_year_index, 'ZZ' ) ).to eq( subject.fnma_fhlmc_25_30_year_index )
      expect( subject.state_row_index( subject.fnma_fhlmc_25_30_year_index, 'AK' ) ).to eq( 6 )
      expect( subject.state_row_index( subject.fnma_fhlmc_25_30_year_index, 'DC' ) ).to eq( 13 )
      expect( subject.state_row_index( subject.fnma_fhlmc_25_30_year_index, 'MN' ) ).to eq( 29 )
      expect( subject.state_row_index( subject.fnma_fhlmc_25_30_year_index, 'OH' ) ).to eq( 41 )
      expect( subject.state_row_index( subject.fnma_fhlmc_25_30_year_index, 'WY' ) ).to eq( 56 )

      expect( subject.state_row_index( subject.fnma_fhlmc_20_year_index, 'ZZ' ) ).to eq( subject.fnma_fhlmc_20_year_index )
      expect( subject.state_row_index( subject.fnma_fhlmc_20_year_index, 'AK' ) ).to eq( 71 )
      expect( subject.state_row_index( subject.fnma_fhlmc_20_year_index, 'DC' ) ).to eq( 78 )
      expect( subject.state_row_index( subject.fnma_fhlmc_20_year_index, 'MN' ) ).to eq( 94 )
      expect( subject.state_row_index( subject.fnma_fhlmc_20_year_index, 'OH' ) ).to eq( 106 )
      expect( subject.state_row_index( subject.fnma_fhlmc_20_year_index, 'WY' ) ).to eq( 121 )
    end

    it '#best_effort_from_amount' do
      expect( subject.best_effort_from_amount(  80000, 'AK', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.22 )
      expect( subject.best_effort_from_amount( 100000, 'AK', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.32 )
      expect( subject.best_effort_from_amount( 140000, 'AK', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.41 )
      expect( subject.best_effort_from_amount( 175000, 'AK', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.44 )
      expect( subject.best_effort_from_amount( 480000, 'AK', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 2.45 )

      expect( subject.best_effort_from_amount(  80000, 'DC', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.16 )
      expect( subject.best_effort_from_amount( 100000, 'DC', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.26 )
      expect( subject.best_effort_from_amount( 140000, 'DC', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.35 )
      expect( subject.best_effort_from_amount( 175000, 'DC', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.38 )
      expect( subject.best_effort_from_amount( 480000, 'DC', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 2.25 )

      expect( subject.best_effort_from_amount(  80000, 'MN', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.15 )
      expect( subject.best_effort_from_amount( 100000, 'MN', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.25 )
      expect( subject.best_effort_from_amount( 140000, 'MN', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.34 )
      expect( subject.best_effort_from_amount( 175000, 'MN', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.37 )
      expect( subject.best_effort_from_amount( 480000, 'MN', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 2.19 )

      expect( subject.best_effort_from_amount(  80000, 'OH', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.20 )
      expect( subject.best_effort_from_amount( 100000, 'OH', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.30 )
      expect( subject.best_effort_from_amount( 140000, 'OH', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.39 )
      expect( subject.best_effort_from_amount( 175000, 'OH', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.42 )
      expect( subject.best_effort_from_amount( 480000, 'OH', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 2.18 )

      expect( subject.best_effort_from_amount(  80000, 'WY', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.05 )
      expect( subject.best_effort_from_amount( 100000, 'WY', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.15 )
      expect( subject.best_effort_from_amount( 140000, 'WY', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.24 )
      expect( subject.best_effort_from_amount( 175000, 'WY', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 3.27 )
      expect( subject.best_effort_from_amount( 480000, 'WY', subject.fnma_fhlmc_25_30_year_index ) ).to be_within(0.001).of( 2.21 )


      expect( subject.best_effort_from_amount(  80000, 'AK', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.31 )
      expect( subject.best_effort_from_amount( 100000, 'AK', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.65 )
      expect( subject.best_effort_from_amount( 140000, 'AK', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.80 )
      expect( subject.best_effort_from_amount( 175000, 'AK', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.84 )
      expect( subject.best_effort_from_amount( 480000, 'AK', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.49 )

      expect( subject.best_effort_from_amount(  80000, 'DC', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.25 )
      expect( subject.best_effort_from_amount( 100000, 'DC', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.59 )
      expect( subject.best_effort_from_amount( 140000, 'DC', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.74 )
      expect( subject.best_effort_from_amount( 175000, 'DC', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.78 )
      expect( subject.best_effort_from_amount( 480000, 'DC', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.42 )

      expect( subject.best_effort_from_amount(  80000, 'MN', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.24 )
      expect( subject.best_effort_from_amount( 100000, 'MN', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.58 )
      expect( subject.best_effort_from_amount( 140000, 'MN', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.73 )
      expect( subject.best_effort_from_amount( 175000, 'MN', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.77 )
      expect( subject.best_effort_from_amount( 480000, 'MN', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.43 )

      expect( subject.best_effort_from_amount(  80000, 'WY', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.14 )
      expect( subject.best_effort_from_amount( 100000, 'WY', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.48 )
      expect( subject.best_effort_from_amount( 140000, 'WY', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.63 )
      expect( subject.best_effort_from_amount( 175000, 'WY', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.67 )
      expect( subject.best_effort_from_amount( 480000, 'WY', subject.fnma_fhlmc_20_year_index ) ).to be_within(0.001).of( 2.33 )
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
