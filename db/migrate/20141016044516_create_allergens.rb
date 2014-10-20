class CreateAllergens < ActiveRecord::Migration
  def change
    create_table :allergens do |t|
      t.string :name,null:false
      t.integer :division
      t.timestamps
    end
  end
end
