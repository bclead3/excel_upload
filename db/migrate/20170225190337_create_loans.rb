class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans, id: :uuid do |t|
      t.string  :borrower_last_name
      t.string  :loan_num
      t.string  :loan_program
      t.decimal :note_rate, precision: 4, scale: 3
      t.decimal :loan_amt, precision: 10, scale: 2
      t.string  :funding_source
      t.string  :investor_loan_num
      t.decimal :loan_trade_total_buy_price, precision: 6, scale: 3
      t.decimal :loan_trade_total_sell_price, precision: 6, scale: 3
      t.decimal :ltv, precision: 6, scale: 3
      t.string  :investor
      t.decimal :bottom_ratio, precision: 9, scale: 3
      t.decimal :combined_ltv, precision: 9, scale: 3
      t.integer :fico
      t.string  :rate_lock_sell_investor_name
      t.string  :investor_status
      t.string  :lock_commitment
      t.string  :lock_status
      t.datetime :lock_request_time
      t.date    :lock_expiration_date
      t.date    :rate_lock_sell_side_lock_date
      t.date    :rate_lock_sell_side_lock_expires_date
      t.date    :closing_date
      t.decimal :closing_disclosure_minus_closing_costs, precision: 9, scale: 2
      t.date    :shipping_actual_shipping_date
      t.string  :lock_status
      t.date    :est_closing_date
      t.date    :closing_disclosure_received_date
      t.string  :last_finished_milestone
      t.string  :borrower_first_name
      t.integer :days_until_lock_expires
      t.decimal :rate_lock_sell_side_gain_loss_percent, precision: 5, scale: 3
      t.decimal :rate_lock_sell_side_base_price_total_adjust, precision: 5, scale: 3
      t.string  :impounds_waived
      t.decimal :rate_lock_sell_side_total_sell_price, precision: 7, scale: 3
      t.decimal :rate_lock_sell_side_srp_paid_out, precision: 5, scale: 3

      t.timestamps null: false
    end
    add_index :loans, :loan_num, unique: true
  end
end
