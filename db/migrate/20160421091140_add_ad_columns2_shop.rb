class AddAdColumns2Shop < ActiveRecord::Migration
  def change
    add_column :shops,:ad_week,:integer,null:true
    add_column :shops,:ad_time,:integer,null:true
    add_column :shops,:wage,:integer,null:true
    add_column :shops,:ad_comment,:string,limit:190,null:true
  end
end
