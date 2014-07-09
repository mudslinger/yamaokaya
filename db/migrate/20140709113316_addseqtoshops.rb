class Addseqtoshops < ActiveRecord::Migration
  def change
  	add_column :shops,:seq,:integer,null:true
  end
end
