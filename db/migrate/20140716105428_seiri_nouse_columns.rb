class SeiriNouseColumns < ActiveRecord::Migration
  def change
    #area
    remove_column :areas, :whole_prefecture
    remove_column :areas, :lat
    remove_column :areas, :lng
    #pref
    remove_column :prefectures,:whole_region
    remove_column :prefectures,:lat
    remove_column :prefectures,:lng
    #region
    remove_column :regions,:lat
    remove_column :regions,:lng
  end
end
