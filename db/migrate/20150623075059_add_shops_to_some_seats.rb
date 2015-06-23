class AddShopsToSomeSeats < ActiveRecord::Migration
  def change
    add_column :shops,:seats_at_booth,:integer,null:true
    add_column :shops,:seats_at_table,:integer,null:true
    add_column :shops,:seats_at_parlor,:integer,null:true
  end
end
