class ChangeShops < ActiveRecord::Migration
  def change
  	add_column :shops,:start_shows,:integer
  end
end
