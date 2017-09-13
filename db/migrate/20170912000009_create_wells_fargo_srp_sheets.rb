class CreateWellsFargoSrpSheets < ActiveRecord::Migration
  def change
    create_table :wells_fargo_srp_sheets, id: :uuid do |t|
      t.string :description
      t.string :thefile

      t.timestamps null: false
    end
  end
end
