class AddCarouselToRelease < ActiveRecord::Migration
  def change
  	add_column :releases,:release_type,:integer
  end
end
