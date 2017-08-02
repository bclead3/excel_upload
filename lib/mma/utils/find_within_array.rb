module MMA
  module Utils
    FICO_Arr        = %w[gte_740 720_to_739 700_to_719 680_to_699 660_to_679 640_to_659 620_to_639 lt_620]
    LTV_Range_2_Arr = %w[ltv_lte_60 ltv_60_01_to_70 ltv_70_01_to_75 ltv_75_01_to_80 ltv_80_01_to_85 ltv_85_01_to_90 ltv_90_01_to_95 ltv_asterisk_95_01_to_97 ltv_hash_95_01_to_97]

    class FindWithinArray

      def self.find(arr, val)
        return_index = nil
        if arr.is_a?(Array)
          if arr.count > 0 && arr[0].is_a?(String) && val.is_a?(Numeric)
            arr.each_with_index do |element|
              element_sub_arr = convert_string_to_array( element )
              begin_end_arr   = numeric_ends( element_sub_arr )
            end
          elsif arr.count > 0 && arr[0].is_a?(Fixnum) && val.is_a?(Fixnum)
            arr.index(val)
          end
        end
        return_index
      end

      #private

      def self.convert_string_to_array( string_val )
        new_arr = []
        if string_val.is_a?(String)
          new_string = string_val
                           .gsub('_to_',' ')
                           .gsub('ltv_','')
                           .gsub('lte','<=')
                           .gsub('gte','>=')
                           .gsub('lt','<')
                           .gsub('gt','>')
                           .gsub('_01','.01')
                           .gsub('_',' ')
          puts "new_string:#{new_string}"
          new_arr = new_string.split(' ')
        end
      end

      def self.numeric_ends( test_arr )
        out_arr = []
        if test_arr.is_a?(Array)
          test_arr.each do |element|
            unless(element == 'hash' || element == 'asterisk')
              if element == '==' ||
                  element == '<=' ||
                  element == '<'  ||
                  element == '>=' ||
                  element == '<='
                out_arr << element
              elsif eval(element).is_a?(Numeric)
                out_arr << element
              end
            end
          end
        end
        out_arr
      end
    end
  end
end
