	class CreateShops < ActiveRecord::Migration
	def change
		create_table :shops do |t|
			t.integer :old_code
			t.string :name,limit:62,null:false
			t.string :furigana,limit:62,null:true
			t.string :gname,limit:62,null:true
			t.string :postal_code ,limit:7,null:true
			t.integer :prefecture,null:false
			t.string :address ,limit:127,null:true
			t.string :phone ,limit: 15,null:true
			t.decimal :lat, precision: 11, scale: 8, null: true
			t.decimal :lng, precision: 11, scale: 8, null: true
			t.integer :zoom
			t.integer :sunday,limit:8,null: false,default: 0
			t.integer :monday,limit:8,null: false,default: 0
			t.integer :tuesday,limit:8,null: false,default: 0
			t.integer :wednesday,limit:8,null: false,default: 0
			t.integer :thursday,limit:8,null: false,default: 0
			t.integer :friday,limit:8,null: false,default: 0
			t.integer :saturday,limit:8,null: false,default: 0
			t.date :inauguration
			t.date :close
			t.string :landmarks,limit: 127,null:true
			t.timestamps
		end
	end
end
