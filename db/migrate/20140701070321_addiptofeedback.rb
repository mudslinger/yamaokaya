class Addiptofeedback < ActiveRecord::Migration
  def change
  	add_column :feedbacks,:remote_ip,:string,limit:15,null:false
  end
end
