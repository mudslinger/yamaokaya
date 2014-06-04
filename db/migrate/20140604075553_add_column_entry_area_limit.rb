class AddColumnEntryAreaLimit < ActiveRecord::Migration
  def change
  	add_column :entries,:area_restriction,:integer
  end
end
