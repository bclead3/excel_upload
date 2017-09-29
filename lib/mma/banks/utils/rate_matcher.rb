
module MMA    # MMA::Banks::Utils::RateMatcher.new( p_hash, a_hash, srp_hash ).find_rate_price
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
          loan_type   = loan_hash['type']
          loan_years  = loan_hash['years']
          loan_rate   = loan_hash['note_rate']
          loan_ltv    = loan_hash['ltv']
          loan_c_ltv  = loan_hash['combined_ltv']
          loan_fico   = loan_hash['fico']
          fico_cutoff = loan_hash['fico_high_low']
          loan_milestone = loan_hash['last_milestone']
          price_hash = {}
          if loan_type == 'FNMA'
            if loan_years == 30
              if price_hash = @price_hash[:conventional_fixed_rates]["#{loan_years}yr"][loan_rate]
                puts price_hash
              else
                puts "no 30yr price info for #{loan_hash}"
              end
            elsif loan_years == 20 || loan_years == 25
              if price_hash = @price_hash[:conventional_fixed_rates]['20yr'][loan_rate]
                puts price_hash
              else
                puts "no 20yr price info for #{loan_hash}"
              end
            elsif loan_years == 15
              if price_hash = @price_hash[:conventional_fixed_rates]['15yr'][loan_rate]
                puts price_hash
              else
                puts "no 15yr price info for #{loan_hash}"
              end
            elsif loan_years == 10
              if price_hash = @price_hash[:conventional_fixed_rates]['10yr'][loan_rate]
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
          price_hash
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

# {"id"=>"04e58bac-ccee-4703-963c-2fd8b8fec6de", "borrower_last_name"=>"ycelo", "loan_num"=>"16053298", "loan_program"=>"Non-Agency Ful", "note_rate"=>"3.875", "loan_amt"=>"724000.0", "funding_source"=>" ", "investor_loan_num"=>"1100754094", "loan_trade_total_buy_price"=>"100.719", "loan_trade_total_sell_price"=>"101.069", "ltv"=>"80.0", "investor"=>"Chase", "bottom_ratio"=>"6.536", "combined_ltv"=>"80.0", "fico"=>708, "rate_lock_sell_investor_name"=>"JP Morgan Chase Bank, N.A", "investor_status"=>" ", "lock_commitment"=>"Long", "lock_status"=>"Locked", "lock_request_time"=>"2016-07-14T11:59:00.000Z", "lock_expiration_date"=>"2016-08-10", "rate_lock_sell_side_lock_date"=>"2016-07-14", "rate_lock_sell_side_lock_expires_date"=>"2016-08-15", "closing_date"=>"2016-07-22", "closing_disclosure_minus_closing_costs"=>"15740.76", "shipping_actual_shipping_date"=>nil, "est_closing_date"=>"2016-07-22", "closing_disclosure_received_date"=>"2016-07-19", "last_finished_milestone"=>"Closing", "borrower_first_name"=>"lcsehar", "days_until_lock_expires"=>27, "rate_lock_sell_side_gain_loss_percent"=>"0.35", "rate_lock_sell_side_base_price_total_adjust"=>"-0.375", "impounds_waived"=>"Not Waived", "rate_lock_sell_side_total_sell_price"=>"101.069", "rate_lock_sell_side_srp_paid_out"=>"0.0", "created_at"=>"2017-09-27T20:58:33.445Z", "updated_at"=>"2017-09-27T20:58:33.445Z", "us_state"=>"MN", "property_type"=>"single-family"}
