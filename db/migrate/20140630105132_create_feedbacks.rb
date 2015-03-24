class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :mail_addr,limit: 126,null:false
      t.string :name,limit:62,null:false
      t.integer :age,null:true
      t.boolean :male,null:true
      t.string :address,limit: 254,null:true
      t.string :phone,limit:30,null:false
      t.string :ip_addr,limit:15,null:true
      t.float :lat,null:true
      t.float :lng,null:true
      t.string :region,limit:254,null:true
      t.integer :shop_id
      t.integer :menu_id
      t.date :visit_date
      t.integer :visit_time
      t.integer :repetition
      t.timestamps
    end
  end
end
