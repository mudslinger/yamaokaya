class ModifyWishedShops < ActiveRecord::Migration
  def change
  	remove_column :wished_shops,:distance_from_their_home
  end
end
