class Region < ActiveRecord::Base
	include ShopArea
	has_many :prefectures,->{order(:seq)},inverse_of: :region

	default_scope -> {
		order(:seq)
	}
	scope :by_zoom, ->(zoom) {
		where("#{zoom} between regions.start_shows and regions.end_shows")
	}
	scope :has_shops, -> {
		includes(
			:prefectures => {
				:areas => :shops
			}
		).where.not(shops: {id: nil})}

	def areas
		prefectures.map do |a|
			a
		end.flatten
	end
	def shops
		prefectures.map do |a|
			a.shops
		end.flatten
	end
	def children_center
		prefectures.map do |p|
			p.center
		end.select do |p|
			p != [nil,nil] && p != [0.0]
		end
	end

	def sprite_x
		(seq-1) % 10 * 53
	end

	def sprite_y
		(seq-1).div(10) * 32
	end
end
