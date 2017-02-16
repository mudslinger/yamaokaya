class CreateJobopLogs < ActiveRecord::Migration
  def change
    create_table :jobop_logs do |t|
			t.integer :shop_id
			t.integer :banner_number
      t.timestamps
    end
  end
end
