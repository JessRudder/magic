class AddPowerAndToughnessToCard < ActiveRecord::Migration
  def change
    add_column :cards, :power, :integer
    add_column :cards, :toughness, :integer
  end
end
