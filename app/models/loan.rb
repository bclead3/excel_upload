class Loan < ActiveRecord::Base

  def dollar_margin
    ( self.rate_lock_sell_side_gain_loss_percent / 100.0 ) * self.loan_amt
  end

  def expected_house_margin
    ( self.loan_trade_total_sell_price - self.loan_trade_total_buy_price ) if self.loan_trade_total_sell_price && self.loan_trade_total_buy_price
  end
end
