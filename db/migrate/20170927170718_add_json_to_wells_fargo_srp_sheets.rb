class AddJsonToWellsFargoSrpSheets < ActiveRecord::Migration
  def change
    add_column :wells_fargo_srp_sheets, :json, :text
  end
end
