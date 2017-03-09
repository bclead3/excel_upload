class CreateExcelFiles < ActiveRecord::Migration
  def change
    create_table :excel_files, id: :uuid do |t|
      t.string :description
      t.string :xl

      t.timestamps null: false
    end
  end
end
