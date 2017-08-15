module MMA

  FNMA_15_TYPE_ARRAY = ['10/1 Conventio', 'Conf Fixed 10', 'Conf Fixed 15', 'FNMA Fixed 10', 'FNMA Fixed 15']
  FNMA_30_TYPE_ARRAY = ['Conf Fixed 20', 'Conf Fixed 25', 'Conf Fixed 30', 'Conf FNMA Fixe', 'Conforming Fix', 'DU Refi Plus I', 'FHLMC Conf Fix', 'FNMA Fixed 20', 'FNMA Fixed 25', 'FNMA Fixed 30']
  GNMA_15_TYPE_ARRAY = ['FHA Fixed 15', 'FHA Fixed 15 G']
  GNMA_30_TYPE_ARRAY = ['VA IRRRL Fixed', 'VA Fixed 30', 'FHA Fixed 20', 'FHA Fixed 25','FHA Fixed 30', 'FHA Fixed 30 G', 'VA Fixed 30 GN', 'FHA GNMA II Fi', 'FHA Streamline']
  NON_CONFORMING_ARR = ['MHFA Conventio', 'GRH Fixed 30', 'Non-Agency Ful', 'MHFA 2nd - Mon', 'MHFA FHA Fixed']

  class Loan < ActiveRecord::Base
    LAST_FINISHED_MILESTONE_CLOSED              = %w[Funding Shipping Pre-Closing Disclosure Completion Purchased Closed]
    LAST_FINISHED_MILESTONE_CLOSED_SEPARATE_RPT = %w[Completion Purchased]
    INVESTOR_STATUS_CLOSED                      = %w[Shipped Purchased Assigned]
    INVESTOR_STATUS_CLOSED_SEPARATE_RPT         = %w[Assigned]

    def dollar_margin
      ( self.rate_lock_sell_side_gain_loss_percent / 100.0 ) * self.loan_amt
    end

    def expected_house_margin
      ( self.loan_trade_total_sell_price - self.loan_trade_total_buy_price ) if self.loan_trade_total_sell_price && self.loan_trade_total_buy_price
    end

    def is_closed
      return_val = false
      if ! self.funding_source.blank?
        return_val = true
      end
      if self.closing_disclosure_received_date && self.closing_disclosure_received_date <= Date.parse('2016-07-20')
        return_val = true
      end
      if LAST_FINISHED_MILESTONE_CLOSED.member?( self.last_finished_milestone )
        return_val = true
      end
      if INVESTOR_STATUS_CLOSED.member?( self.investor_status )
        return_val = true
      end
      return_val
    end

    def closed_reasons
      return_arr = []
      if self.is_closed
        if ! self.funding_source.blank?
          return_arr << "has #{self.funding_source} as a funding source"
        end
        if self.closing_disclosure_received_date && self.closing_disclosure_received_date <= Date.parse('2016-07-20')
          return_arr << "closing disclosure received date is less than #{Date.parse('2016-07-20')}"
        end
        if LAST_FINISHED_MILESTONE_CLOSED.member?( self.last_finished_milestone )
          return_arr << "The last finished milestone is:#{self.last_finished_milestone}"
        end
        if INVESTOR_STATUS_CLOSED.member?( self.investor_status )
          return_arr << "The investor status is:#{self.investor_status}"
        end
      end
      return_arr
    end

    def separate_report
      return_arr = []
      if self.is_closed
        if LAST_FINISHED_MILESTONE_CLOSED_SEPARATE_RPT.member?( self.last_finished_milestone )
          return_arr << 'Closed Out Loans'
        end
        if INVESTOR_STATUS_CLOSED_SEPARATE_RPT.member?( self.investor_status )
          return_arr << 'Assigned Report'
        end
      end
      return_arr
    end
  end
end
