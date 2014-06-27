class Prefecture < ActiveRecord::Base
	include ShopArea
	default_scope ->{
		order(:seq)
	}
	scope :by_zoom, ->(zoom) {
		where("#{zoom} between prefectures.start_shows and prefectures.end_shows")
	}
	has_many :areas,->{order(:seq)},inverse_of: :prefecture
	belongs_to :region
	scope :has_shops, -> {includes(:areas => :shops).where.not(shops: {id: nil})}
	scope :with_higher, ->{
		includes(:region)
	}
	scope :by_region, ->(id) {where(region_id: id)}

	def shops
		areas.map do |a|
			a.shops
		end.flatten
	end
	def children_center
		areas.map do |p|
			p.center
		end.select do |p|
			p != [nil,nil] && p != [0.0]
		end
	end

end
