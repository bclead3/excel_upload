class AddJsonToWellsFargoPriceSheets < ActiveRecord::Migration
  def change
    add_column :wells_fargo_price_sheets, :json, :text
  end
end
