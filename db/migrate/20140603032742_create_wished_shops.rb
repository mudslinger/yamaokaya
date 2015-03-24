class CreateWishedShops < ActiveRecord::Migration
  def change
    create_table :wished_shops do |t|
		t.integer :entry_id
		t.integer :shop_id
		t.float :distance_from_their_home
		t.timestamps
    end
  end
end
