class ModifyEntry < ActiveRecord::Migration
  def change
  	add_column :entries,:remote_ip, :string,limit: 15
  	add_column :entries,:lat,:float
  	add_column :entries,:lng,:float
  end
end
