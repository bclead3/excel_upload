class CreateWellsFargoPriceSheets < ActiveRecord::Migration
  def change
    create_table :wells_fargo_price_sheets, id: :uuid do |t|
      t.string :description
      t.string :thefile

      t.timestamps null: false
    end
  end
end
