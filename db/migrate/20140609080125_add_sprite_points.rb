class AddSpritePoints < ActiveRecord::Migration
  def change
  	add_column :regions,:sprite_x,:integer
  	add_column :prefectures,:sprite_x,:integer
  	add_column :areas,:sprite_x,:integer
  	add_column :regions,:sprite_y,:integer
  	add_column :prefectures,:sprite_y,:integer
  	add_column :areas,:sprite_y,:integer
  end
end
