module MMA
  module Excel
    BASE_DATE = DateTime.new(1899,12,30)
    class ExcelUtils

      def self.parse_date( value )
        if value.to_i > 0
          BASE_DATE + value.to_i.days
        else
          value
        end
      end

      def self.parse_to_yyyy_mm_dd( value )
        if value.to_i > 0
          parse_date( value ).strftime('%Y-%m-%d')
        else
          value
        end
      end
    end
  end
end
