class AddIptoJobopLog < ActiveRecord::Migration
  def change
    add_column :jobop_logs,:ip_addr,:string,null:true
  end
end
