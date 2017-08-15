
module MMA
  module Banks
    module Utils
      class RateMatcher

        attr_accessor :price_hash, :adjuster_hash

        def initialize( price_hash, adjuster_hash )
          @price_hash     = price_hash
          @adjuster_hash  = adjuster_hash
        end

        def find_rate_price( loan_hash )

        end
      end
    end
  end
end
