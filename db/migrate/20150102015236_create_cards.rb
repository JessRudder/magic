class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.string :mana_cost
      t.integer :converted_mana_cost
      t.string :type
      t.text :rules
      t.string :set
      t.string :color

      t.timestamps
    end
  end
end
