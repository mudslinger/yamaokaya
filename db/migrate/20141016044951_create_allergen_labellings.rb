class CreateAllergenLabellings < ActiveRecord::Migration
  def change
    create_table :allergen_labellings do |t|
      t.integer :menu_id
      t.integer :allergen_id
      t.integer :label
      t.timestamps
    end
  end
end
