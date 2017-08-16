
module MMA    # MMA::Banks::Utils::RateMatcher.new( p_hash, a_hash ).find_rate_price
  module Banks
    module Utils
      class RateMatcher

        attr_accessor :price_hash, :adjuster_hash, :srp_hash

        def initialize( price_hash, adjuster_hash, srp_hash )
          @price_hash     = price_hash
          @adjuster_hash  = adjuster_hash
          @srp_hash       = srp_hash
        end

        def find_rate_price( loan_hash )
          loan_type   = loan_hash[:type]
          loan_years  = loan_hash[:years]
          loan_rate   = loan_hash[:rate]
          loan_ltv    = loan_hash[:ltv]
          loan_c_ltv  = loan_hash[:combined_ltv]
          loan_fico   = loan_hash[:fico]
          fico_cutoff = loan_hash[:fico_high_low]
          loan_milestone = loan_hash[:last_milestone]

          if loan_type == 'FNMA'
            if loan_years == 30
              if price_hash = @price_hash[:conventional_fixed_rates]["#{loan_years}yr"][loan_rate]
                puts price_hash
              else
                puts "no 30yr price info for #{loan_hash}"
              end
            elsif loan_years == 20 || loan_years == 25
              if price_hash = @price_hash[:conventional_fixed_rates]["20yr"][loan_rate]
                puts price_hash
              else
                puts "no 20yr price info for #{loan_hash}"
              end
            elsif loan_years == 15
              if price_hash = @price_hash[:conventional_fixed_rates]["15yr"][loan_rate]
                puts price_hash
              else
                puts "no 15yr price info for #{loan_hash}"
              end
            elsif loan_years == 10
              if price_hash = @price_hash[:conventional_fixed_rates]["10yr"][loan_rate]
                puts price_hash
              else
                puts "no 10yr price info for #{loan_hash}"
              end
            end
          elsif loan_type == 'GNMA'
            puts 'GNMA'
          elsif loan_type == 'non conforming (identified)'
            puts 'non conforming (identified)'
          end
        end
      end
    end
  end
end

# {:loan_id=>"Flagstar::16063795",
#  :program=>"Conf FNMA Fixe",
#  :type=>"FNMA",
#  :duration=>"20 years or more",
#  :years=>30,
#  :amount=>"94400.0",
#  :rate=>"3.125",
#  :ltv=>"80.0",
#  :combined_ltv=>"80.0",
#  :fico=>777,
#  :fico_high_low=>"above cutoff",
#  :last_milestone=>"Qualification",
#  :lock_status=>"Locked"}
