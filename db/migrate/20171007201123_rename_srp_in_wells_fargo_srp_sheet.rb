class RenameSrpInWellsFargoSrpSheet < ActiveRecord::Migration
  def change
    rename_column :wells_fargo_srp_sheets, :srp, :thefile
  end
end
