class CreateMenus < ActiveRecord::Migration
	def change
		create_table :menus do |t|
			t.string :name,limit:126,null:false
			t.integer :category,null:false
			t.integer :subcategory,null:false
			t.integer :taste,null:true
			t.integer :ingredients,null:true
			t.boolean :has_large_sizes,null:true
			t.boolean :is_hot,null:true
			t.date :start_sells,null:false
			t.date :end_sells,null:false
			t.date :start_promote,null:true
			t.date :end_promote,null:true
			t.integer :price,null:false
			t.text :comment
			t.integer :push_priority
			t.timestamps
		end
	end
end
