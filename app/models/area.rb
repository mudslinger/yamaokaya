class Area < ActiveRecord::Base
	include ShopArea
	has_many :shops,->(record) {where("(current_timestamp between [inauguration] and [close]) or (abs(datediff(d,current_timestamp,inauguration)) < 30)").order(:id)},inverse_of: :area
	belongs_to :prefecture
	default_scope ->{order(:seq)}
	scope :by_zoom, ->(zoom) {
		where("#{zoom} between areas.start_shows and areas.end_shows")
	}
	scope :not_whole, -> {where(whole_prefecture: false)}
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
end
