class Addseatstoshops < ActiveRecord::Migration
  def change
  	add_column :shops,:seats_at_counter,:integer,null:true
  	add_column :shops,:booths,:integer,null:true
  end
end
