class CreateReleases < ActiveRecord::Migration
	def change
		create_table :releases do |t|
			t.datetime :start_shows,null:false
			t.datetime :end_shows,null:false
			t.datetime :target_date,null:false
			t.string :title,limit: 254,null:false
			t.string :url,limit:254,null:false
			t.text :body
			t.integer :shop_id
			t.integer :menu_group_id
			t.timestamps
		end
	end
end
