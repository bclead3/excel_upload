
module MMA
  module Excel
    class ParseExcel


      def self.process_array( arr )
        Loan.destroy_all if arr && arr.count > 0
        arr.each do |sub_arr|
          loan_assign( sub_arr )
        end
        nil
      end

      def self.process_array_locally( arr )
        arr.each do |sub_arr|
          if /\d+/.match( sub_arr[1] )
            Rails.logger.debug "There was a loan number:#{sub_arr[1]}"
            l_obj = LoanObj.new( sub_arr )
            Rails.logger.debug 'Loan Object'
            Rails.logger.debug l_obj.inspect
          end
        end
        nil
      end

      def self.loan_assign( arr )
        Rails.logger.debug "about to assign the following:#{arr}"
        borrower_last_name  = arr[0]
        loan_num            = arr[1] # index
        loan_program        = arr[2]
        note_rate           = arr[3]
        loan_amt            = arr[4]
        funding_source      = arr[5]
        investor_loan_num   = arr[6]
        loan_trade_total_buy_price  = arr[7]
        loan_trade_total_sell_price = arr[8]
        ltv                         = arr[9]
        investor                    = arr[10]
        bottom_ratio                = arr[11]
        combined_ltv                = arr[12]
        fico                        = arr[13]
        rate_lock_sell_investor_name  = arr[14]
        investor_status               = arr[15]
        lock_commitment               = arr[16]
        lock_status                   = arr[17]
        lock_request_time             = arr[18]
        lock_expiration_date                  = arr[19]
        rate_lock_sell_side_lock_date         = arr[20]
        rate_lock_sell_side_lock_expires_date = arr[21]
        closing_date                          = arr[22]
        closing_disclosure_minus_closing_costs= arr[23]
        shipping_actual_shipping_date         = arr[24]
        lock_status                           = arr[25]
        est_closing_date                      = arr[26]
        closing_disclosure_received_date      = arr[27]
        last_finished_milestone               = arr[28]
        borrower_first_name                   = arr[29]
        days_until_lock_expires               = arr[30]
        rate_lock_sell_side_gain_loss_percent = arr[31]
        rate_lock_sell_side_base_price_total_adjust = arr[32]
        impounds_waived                             = arr[33]
        rate_lock_sell_side_total_sell_price        = arr[34]
        rate_lock_sell_side_srp_paid_out            = arr[35]

        if /\d+/.match( loan_num )
          ::Loan.find_or_create_by(loan_num: loan_num) do |loan|
            Rails.logger.debug "loan:#{loan.inspect}"
            loan.borrower_last_name                 = borrower_last_name
            loan.loan_num                           = loan_num
            loan.loan_program                       = loan_program
            loan.note_rate                          = note_rate
            loan.loan_amt                           = loan_amt
            loan.funding_source                     = funding_source
            loan.investor_loan_num                  = investor_loan_num
            loan.loan_trade_total_buy_price         = loan_trade_total_buy_price
            loan.loan_trade_total_sell_price        = loan_trade_total_sell_price
            loan.ltv                                = ltv
            loan.investor                           = investor
            loan.bottom_ratio                       = bottom_ratio
            loan.combined_ltv                       = combined_ltv
            loan.fico                               = fico
            loan.rate_lock_sell_investor_name       = rate_lock_sell_investor_name
            loan.investor_status                    = investor_status
            loan.lock_commitment                    = lock_commitment
            loan.lock_status                        = lock_status
            loan.lock_request_time                  = lock_request_time
            loan.lock_expiration_date                  = lock_expiration_date
            loan.rate_lock_sell_side_lock_date         = rate_lock_sell_side_lock_date
            loan.rate_lock_sell_side_lock_expires_date = rate_lock_sell_side_lock_expires_date
            loan.closing_date                          = closing_date
            loan.closing_disclosure_minus_closing_costs= closing_disclosure_minus_closing_costs
            loan.shipping_actual_shipping_date         = shipping_actual_shipping_date
            loan.lock_status                           = lock_status
            loan.est_closing_date                      = est_closing_date
            loan.closing_disclosure_received_date      = closing_disclosure_received_date
            loan.last_finished_milestone               = last_finished_milestone
            loan.borrower_first_name                   = borrower_first_name
            loan.days_until_lock_expires               = days_until_lock_expires
            loan.rate_lock_sell_side_gain_loss_percent = rate_lock_sell_side_gain_loss_percent
            loan.rate_lock_sell_side_base_price_total_adjust = rate_lock_sell_side_base_price_total_adjust
            loan.impounds_waived                             = impounds_waived
            loan.rate_lock_sell_side_total_sell_price        = rate_lock_sell_side_total_sell_price
            loan.rate_lock_sell_side_srp_paid_out            = rate_lock_sell_side_srp_paid_out
            Rails.logger.debug 'loan'
            loan.save!
            Rails.logger.debug loan
          end
        end
      end
    end

    class LoanObj

      attr_accessor :borrower_last_name, :loan_num, :loan_program, :note_rate, :loan_amt, :funding_source, :investor_loan_num, :loan_trade_total_buy_price, :loan_trade_total_sell_price, :ltv, :investor, :bottom_ratio, :combined_ltv, :fico, :rate_lock_sell_investor_name, :investor_status, :lock_commitment, :lock_status, :lock_request_time, :lock_expiration_date, :rate_lock_sell_side_lock_date, :rate_lock_sell_side_lock_expires_date, :closing_date, :closing_disclosure_minus_closing_costs, :shipping_actual_shipping_date, :lock_status, :est_closing_date, :closing_disclosure_received_date, :last_finished_milestone, :borrower_first_name, :days_until_lock_expires, :rate_lock_sell_side_gain_loss_percent, :rate_lock_sell_side_base_price_total_adjust, :impounds_waived, :rate_lock_sell_side_total_sell_price, :rate_lock_sell_side_srp_paid_out

      def initialize( arr )
        Rails.logger.debug 'initialized LoanObj, about to assign array...'
        assign( arr ) unless arr.nil?
      end

      def assign( arr )
        @borrower_last_name  = arr[0]
        @loan_num            = arr[1]
        @loan_program        = arr[2]
        @note_rate           = arr[3]
        @loan_amt            = arr[4]
        @funding_source      = arr[5]
        @investor_loan_num   = arr[6]
        @loan_trade_total_buy_price  = arr[7]
        @loan_trade_total_sell_price = arr[8]
        @ltv                         = arr[9]
        @investor                    = arr[10]
        @bottom_ratio                = arr[11]
        @combined_ltv                = arr[12]
        @fico                        = arr[13]
        @rate_lock_sell_investor_name  = arr[14]
        @investor_status               = arr[15]
        @lock_commitment               = arr[16]
        @lock_status                   = arr[17]
        @lock_request_time             = arr[18]
        @lock_expiration_date                  = arr[19]
        @rate_lock_sell_side_lock_date         = arr[20]
        @rate_lock_sell_side_lock_expires_date = arr[21]
        @closing_date                          = arr[22]
        @closing_disclosure_minus_closing_costs= arr[23]
        @shipping_actual_shipping_date         = arr[24]
        @lock_status                           = arr[25]
        @est_closing_date                      = arr[26]
        @closing_disclosure_received_date      = arr[27]
        @last_finished_milestone               = arr[28]
        @borrower_first_name                   = arr[29]
        @days_until_lock_expires               = arr[30]
        @rate_lock_sell_side_gain_loss_percent = arr[31]
        @rate_lock_sell_side_base_price_total_adjust = arr[32]
        @impounds_waived                             = arr[33]
        @rate_lock_sell_side_total_sell_price        = arr[34]
        @rate_lock_sell_side_srp_paid_out            = arr[35]
      end

    end
  end
end
