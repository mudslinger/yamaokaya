class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
    	t.boolean :whole_prefecture,default: false
    	t.integer :prefecture_id
    	t.string :name,limit: 62,null:false
    	t.integer :start_shows
    	t.integer :end_shows
    	t.float :lat
    	t.float :lng
      t.timestamps
    end
  end
end
