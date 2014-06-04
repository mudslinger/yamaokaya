class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
		t.string :name,limit: 126,null:false
		t.integer :sex, null:false					#enum
		t.integer :work_type,null:false				#enum
		t.date :birthday
		t.string :postal_code,limit:7,null:true
		t.string :address,limit: 253,null:true
		t.string :phone,limit: 15,null:true
		t.string :mail_addr,limit: 63,null:true
		t.integer :contact_means,null:false			#enum
		t.integer :work_commencing_time,null:false  #enum
		t.integer :work_times,limit: 8,dafault: 0
		t.text :message,null:true
		t.timestamps
    end
  end
end
