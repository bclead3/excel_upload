class RenameSrpInWellsFargoSrpSheet < ActiveRecord::Migration
  def up
    unless column_exists? :wells_fargo_srp_sheets, :thefile
      rename_column :wells_fargo_srp_sheets, :srp, :thefile
    end
  end

  def down
    unless column_exists? :wells_fargo_srp_sheets, :srp
      rename_column :wells_fargo_srp_sheets, :thefile, :srp
    end
  end
end
