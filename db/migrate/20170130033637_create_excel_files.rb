class CreateExcelFiles < ActiveRecord::Migration
  def change
    create_table :excel_files do |t|
      t.string :name
      t.string :xl

      t.timestamps null: false
    end
  end
end
