class ChangeReleaseUrlToAllowNull < ActiveRecord::Migration
  def change
  	change_column(:releases, :url, :string, :null => true)
  end
end
