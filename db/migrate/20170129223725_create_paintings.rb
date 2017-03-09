class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings, id: :uuid do |t|
      t.integer :gallery_id
      t.string :name
      t.string :image
      t.string :remote_image_url
      t.string :xl

      t.timestamps null: false
    end
  end
end
