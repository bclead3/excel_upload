class AddStateAndPropertyType < ActiveRecord::Migration
  def change
    # reversible do |dir|
    #   change_table :loans do |t|
    #     dir.up   { t.add :price, :string }
    #     dir.down { t.change :price, :integer }
    #   end
    # end
    add_column :loans, :us_state, :string, default: 'MN'
    add_column :loans, :property_type, :string, default: 'single-family'
  end
end
