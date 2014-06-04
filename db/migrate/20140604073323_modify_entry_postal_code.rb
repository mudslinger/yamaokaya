class ModifyEntryPostalCode < ActiveRecord::Migration
  def change
  	change_column :entries,:postal_code,:string,limit:8,null:true
  end
end
