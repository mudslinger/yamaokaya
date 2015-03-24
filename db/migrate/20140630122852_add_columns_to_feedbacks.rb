class AddColumnsToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks,:q,:integer
  	add_column :feedbacks,:s,:integer
  	add_column :feedbacks,:c,:integer
  	add_column :feedbacks,:a,:integer
  	add_column :feedbacks,:reply,:boolean
  	add_column :feedbacks,:message,:text
  	add_column :feedbacks, :mail_sent,:boolean
  end
end
