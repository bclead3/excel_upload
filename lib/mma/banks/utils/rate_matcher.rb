
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
          loan_type   = loan_hash['type'].upcase
          loan_years  = loan_hash['years'].to_i
          loan_rate   = loan_hash['note_rate']
          # loan_ltv    = loan_hash['ltv']
          # loan_c_ltv  = loan_hash['combined_ltv']
          # loan_fico   = loan_hash['fico']
          # fico_cutoff = loan_hash['fico_high_low']
          # loan_milestone = loan_hash['last_milestone']
          temp_price_hash = {}
          if loan_type == 'FNMA'
            if loan_years >= 30
              if temp_price_hash = @price_hash[:conventional_fixed_rates]['30yr'][loan_rate]
                #puts temp_price_hash
              else
                Rails.logger.warn "no 30yr price info for #{loan_hash['note_rate']}\t#{loan_hash}"
              end
            elsif loan_years >= 20 && loan_years <= 25
              if temp_price_hash = @price_hash[:conventional_fixed_rates]['20yr'][loan_rate]
                #puts temp_price_hash
              else
                Rails.logger.warn "no 20yr price info for #{loan_hash['note_rate']}\t#{loan_hash}"
              end
            elsif loan_years >= 15
              if temp_price_hash = @price_hash[:conventional_fixed_rates]['15yr'][loan_rate]
                #puts temp_price_hash
              else
                Rails.logger.warn "no 15yr price info for #{loan_hash['note_rate']}\t#{loan_hash}"
              end
            elsif loan_years >= 10
              if temp_price_hash = @price_hash[:conventional_fixed_rates]['10yr'][loan_rate]
                #puts temp_price_hash
              else
                Rails.logger.warn "no 10yr price info for #{loan_hash['note_rate']}\t#{loan_hash}"
              end
            end
          elsif loan_type == 'GNMA'
            Rails.logger.info 'GNMA'
          elsif loan_type == 'non conforming (identified)'
            Rails.logger.info 'non conforming (identified)'
          end
          temp_price_hash
        end

        def find_price_adjusters( loan_hash )
          prop_type = loan_hash['property_type']

          adjuster_h = {}
          if prop_type == 'single-family'
            ltv_val   = loan_hash['ltv']
            ltv_range = MMA::Banks::WellsFargo::RateSheet::WellsFargoConformingAdjusters.ltv_range_value_from_percent( ltv_val )
            adjuster_h['ltv_adjustment'] = @adjuster_hash['fixed_investor'][ltv_range]['adjustment']
          end
          adjuster_h
        end

        def find_srp_adjusters( loan_hash )
          program = loan_hash['loan_program']
          state   = loan_hash['us_state']
          loan_amt= loan_hash['loan_amt']

          if MMA::Banks::WellsFargo::SrpAdjusters::WELLS_FARGO_STATE_SYMBOL_ARRAY.index( state.upcase.to_sym )
            out_h   = MMA::Banks::WellsFargo::RegularAdjusters::Adjusters.loan_type( program )
            years       = out_h[:years]
            type        = out_h[:type].downcase
            key_to_use  = ''
            if @srp_hash.is_a?(Hash)
              key_to_use = :fnma_fhlmc_15yr
              @srp_hash.keys.select{|k| k.to_s.downcase.index(type)}.each do |temp_key|
                if temp_key.to_s.index( years.to_s )
                  key_to_use = temp_key
                end
              end
              srp_col_val     = MMA::Banks::WellsFargo::SrpAdjusters::WellsFargoSrpConvFullGrid.srp_col_val_from_amount( loan_amt )
              best_effort_val = @srp_hash[key_to_use][state.upcase.to_sym][:best_effort][srp_col_val]
              mandatory_val   = @srp_hash[key_to_use][state.upcase.to_sym][:mandatory  ][srp_col_val]
              { best_effort: best_effort_val, mandatory: mandatory_val }
            else
              Rails.logger.info "@srp_hash class:#{@srp_hash.class}"
              { best_effort: 'n/a', mandatory: 'n/a', warning: '@srp_hash not valid', srp: @srp_hash }
            end
          else
            { best_effort: 'n/a', mandatory: 'n/a', warning: 'state not found', state: state }

          end
        end
      end
    end
  end
end


# {"id"=>"04e58bac-ccee-4703-963c-2fd8b8fec6de",
# "borrower_last_name"=>"ycelo",
# "loan_num"=>"16053298",
# "loan_program"=>"Non-Agency Ful",
# "note_rate"=>"3.875",
# "loan_amt"=>"724000.0",
# "funding_source"=>" ",
# "investor_loan_num"=>"1100754094",
# "loan_trade_total_buy_price"=>"100.719",
# "loan_trade_total_sell_price"=>"101.069",
# "ltv"=>"80.0",
# "investor"=>"Chase",
# "bottom_ratio"=>"6.536",
# "combined_ltv"=>"80.0",
# "fico"=>708,
# "rate_lock_sell_investor_name"=>"JP Morgan Chase Bank, N.A",
# "investor_status"=>" ",
# "lock_commitment"=>"Long",
# "lock_status"=>"Locked",
# "lock_request_time"=>"2016-07-14T11:59:00.000Z",
# "lock_expiration_date"=>"2016-08-10",
# "rate_lock_sell_side_lock_date"=>"2016-07-14",
# "rate_lock_sell_side_lock_expires_date"=>"2016-08-15",
# "closing_date"=>"2016-07-22",
# "closing_disclosure_minus_closing_costs"=>"15740.76",
# "shipping_actual_shipping_date"=>nil,
# "est_closing_date"=>"2016-07-22",
# "closing_disclosure_received_date"=>"2016-07-19",
# "last_finished_milestone"=>"Closing",
# "borrower_first_name"=>"lcsehar",
# "days_until_lock_expires"=>27,
# "rate_lock_sell_side_gain_loss_percent"=>"0.35",
# "rate_lock_sell_side_base_price_total_adjust"=>"-0.375",
# "impounds_waived"=>"Not Waived",
# "rate_lock_sell_side_total_sell_price"=>"101.069",
# "rate_lock_sell_side_srp_paid_out"=>"0.0",
# "created_at"=>"2017-09-27T20:58:33.445Z",
# "updated_at"=>"2017-09-27T20:58:33.445Z",
# "us_state"=>"MN",
# "property_type"=>"single-family"}
