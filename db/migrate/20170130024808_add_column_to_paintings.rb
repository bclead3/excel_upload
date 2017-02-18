class AddColumnToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :remote_image_url, :string
  end
end
