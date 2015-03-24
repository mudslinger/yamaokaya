class AddMailSentToEntries < ActiveRecord::Migration
  def change
  	add_column :entries,:mail_sent,:boolean,null:true
  end
end
