class AddNoSmokingColumnToShop < ActiveRecord::Migration
  def change
    add_column :shops,:smokeable,:boolean,null:true
  end
end
