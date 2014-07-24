class Release < ActiveRecord::Base
	has_many :shop,inverse_of: :release
	#has_many :menu_group
	default_scope -> {where("(current_timestamp between start_shows and end_shows)")}
	default_scope -> {order('start_shows desc')}
	enum release_type: {news: 0,carousel:1,ir: 2}
	def self.headline
		Release.news.limit(8)
	end
end
