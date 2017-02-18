class AddSecondColumnToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :xl, :string
  end
end
