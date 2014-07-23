class Area < ActiveRecord::Base
	include ShopArea
	has_many :shops,->(record) {where("(current_timestamp between inauguration and close)").order(:id)},inverse_of: :area
	belongs_to :prefecture
	default_scope ->{order(:seq)}
	scope :by_zoom, ->(zoom) {
		where("#{zoom} between areas.start_shows and areas.end_shows")
	}
	scope :has_shops, -> {includes(:shops).where.not(shops: {id: nil})}
	scope :by_prefecture, ->(id) {where(prefecture_id: id)}
	scope :with_higher, ->{
		includes(:prefecture => :region)
	}
	def children_center
		shops.map do |p|
			[p.lat,p.lng]
		end
	end
	def sprite_x
		(seq-1) % 10 * 21
	end

	def sprite_y
		(seq-1).div(10) * 80
	end
end
