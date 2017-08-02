require 'rails_helper'


module MMA
  module Utils

    describe FindWithinArray, '.convert_string_to_array' do
      LTV_Range_2_Arr = %w[ltv_lte_60 ltv_60_01_to_70 ltv_70_01_to_75 ltv_75_01_to_80 ltv_80_01_to_85 ltv_85_01_to_90 ltv_90_01_to_95 ltv_asterisk_95_01_to_97 ltv_hash_95_01_to_97]
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
    end
  end
end
