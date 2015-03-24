class AddShopToParkInfo < ActiveRecord::Migration
  def change
  	add_column :shops,:park_caps,:integer,null:true
  	add_column :shops,:truck_park_caps,:integer,null:true
  end
end
