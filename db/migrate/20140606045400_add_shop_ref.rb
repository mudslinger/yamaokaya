class AddShopRef < ActiveRecord::Migration
  def change
  	add_column :shops,:area_id,:integer
  	remove_column :shops,:prefecture
  end
end
