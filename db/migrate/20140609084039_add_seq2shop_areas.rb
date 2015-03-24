class AddSeq2shopAreas < ActiveRecord::Migration
  def change
  	add_column :regions,:seq,:integer
  	add_column :prefectures,:seq,:integer
  	add_column :areas,:seq,:integer
  end
end
