class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries, id: :uuid do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
