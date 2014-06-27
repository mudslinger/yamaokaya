class RemoveSpritePoints < ActiveRecord::Migration
  def change
  	remove_column :regions,:sprite_x,:integer
  	remove_column :prefectures,:sprite_x,:integer
  	remove_column :areas,:sprite_x,:integer
  	remove_column :regions,:sprite_y,:integer
  	remove_column :prefectures,:sprite_y,:integer
  	remove_column :areas,:sprite_y,:integer
  end
end
