class AddUrlToCard < ActiveRecord::Migration
  def change
    add_column :cards, :image_link, :string
  end
end
