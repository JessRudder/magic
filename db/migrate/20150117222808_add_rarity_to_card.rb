class AddRarityToCard < ActiveRecord::Migration
  def change
    add_column :cards, :rarity, :string
  end
end
