class Release < ActiveRecord::Base
	has_many :shop,inverse_of: :release
	#has_many :menu_group
	scope :active, -> {where("(current_timestamp between start_shows and end_shows)")}
	scope :sorted, -> {order('start_shows desc')}
	enum release_type: {news: 0,carousel:1}
	def self.headline
		Release.active.sorted.limit(8)
	end
end
