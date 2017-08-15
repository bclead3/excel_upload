require 'rails_helper'


module MMA
  module Utils

    describe FindWithinArray, '.convert_string_to_array' do
      #LTV_Range_2_Arr = %w[ltv_lte_60 ltv_60_01_to_70 ltv_70_01_to_75 ltv_75_01_to_80 ltv_80_01_to_85 ltv_85_01_to_90 ltv_90_01_to_95 ltv_asterisk_95_01_to_97 ltv_hash_95_01_to_97]
      it '.convert_string_to_array convert ltv_lte_60 to <= 60' do
        expect( FindWithinArray.convert_string_to_array('ltv_lte_60')).to eq(['<=', '60'])
        expect( FindWithinArray.convert_string_to_array('ltv_60_01_to_70')).to eq(['60.01', '70'])
        expect( FindWithinArray.convert_string_to_array('ltv_asterisk_95_01_to_97') ).to eq(['asterisk','95.01','97'])
        expect( FindWithinArray.convert_string_to_array('ltv_hash_95_01_to_97') ).to eq(['hash','95.01','97'])
      end

      it '.numeric_ends' do
        test_arr = FindWithinArray.convert_string_to_array('ltv_hash_95_01_to_97')
        expect( FindWithinArray.numeric_ends( test_arr ) ).to eq( ['95.01','97'] )

        test_arr = FindWithinArray.convert_string_to_array('ltv_lte_60')
        expect( FindWithinArray.numeric_ends( test_arr ) ).to eq(['<=','60'] )
        # expect().to eq()
        # expect().to eq()
        # expect().to eq()
      end

      it '.find for FICO_Arr' do
        #FICO_Arr        = %w[gte_740 720_to_739 700_to_719 680_to_699 660_to_679 640_to_659 620_to_639 lt_620]
        [740, 741, 799, 800, 900].each do |test_fico|
          expect( FindWithinArray.find( FICO_Arr, test_fico) ).to eq(0)
        end

        [720, 721, 723, 738, 739].each do |test_fico|
          expect( FindWithinArray.find( FICO_Arr, test_fico) ).to eq(1)
        end

        [700, 701, 718, 719].each do |test_fico|
          expect( FindWithinArray.find( FICO_Arr, test_fico) ).to eq(2)
        end

        [680, 681, 698, 699].each do |test_fico|
          expect( FindWithinArray.find( FICO_Arr, test_fico) ).to eq(3)
        end

        [660, 661, 678, 679].each do |test_fico|
          expect( FindWithinArray.find( FICO_Arr, test_fico) ).to eq(4)
        end

        [640, 641, 658, 659].each do |test_fico|
          expect( FindWithinArray.find( FICO_Arr, test_fico) ).to eq(5)
        end

        [620, 621, 638, 639].each do |test_fico|
          expect( FindWithinArray.find( FICO_Arr, test_fico) ).to eq(6)
        end

        [-1, 0, 5, 100, 500, 530, 600, 618, 619].each do |test_fico|
          expect( FindWithinArray.find( FICO_Arr, test_fico) ).to eq(7)
        end
      end

      it '.find for LTV_Range_2_Arr' do
        #LTV_Range_2_Arr = %w[ltv_lte_60 ltv_60_01_to_70 ltv_70_01_to_75 ltv_75_01_to_80 ltv_80_01_to_85 ltv_85_01_to_90 ltv_90_01_to_95 ltv_asterisk_95_01_to_97 ltv_hash_95_01_to_97]
        (59.0..60.0).step(0.1).each do |value|
          expect( FindWithinArray.find( LTV_Range_2_Arr, value ) ).to eq( 0 )
        end
        (60.1..70.0).step(0.1).each do |value|
          expect( FindWithinArray.find( LTV_Range_2_Arr, value ) ).to eq( 1 )
        end
        (70.1..75.0).step(0.1).each do |value|
          expect( FindWithinArray.find( LTV_Range_2_Arr, value ) ).to eq( 2 )
        end
        (75.1..80.0).step(0.1).each do |value|
          expect( FindWithinArray.find( LTV_Range_2_Arr, value ) ).to eq( 3 )
        end
        (80.1..85.0).step(0.1).each do |value|
          expect( FindWithinArray.find( LTV_Range_2_Arr, value ) ).to eq( 4 )
        end
        (85.1..90.0).step(0.1).each do |value|
          expect( FindWithinArray.find( LTV_Range_2_Arr, value ) ).to eq( 5 )
        end
        (90.1..95.0).step(0.1).each do |value|
          expect( FindWithinArray.find( LTV_Range_2_Arr, value ) ).to eq( 6 )
        end
      end
    end
  end
end
