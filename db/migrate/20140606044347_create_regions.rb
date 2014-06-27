class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
    	t.string :name,limit: 62,null:false
    	t.integer :start_shows
    	t.integer :end_shows
    	t.float :lat
    	t.float :lng
      t.timestamps
    end
  end
end
