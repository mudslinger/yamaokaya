class Configfeedback < ActiveRecord::Migration
  def change
  	remove_column :feedbacks,:ip_addr,:integer
  	rename_column :feedbacks, :q, :quality
  	rename_column :feedbacks, :s, :service
  	rename_column :feedbacks, :c, :cleanliness
  	rename_column :feedbacks, :a, :atomosphere
  	
  end
end
