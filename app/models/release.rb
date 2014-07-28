class Release < ActiveRecord::Base
	belongs_to :shop

	#has_many :menu_group
	default_scope -> {where("(current_timestamp between start_shows and end_shows)")}
	default_scope -> {order('target_date desc')}

	scope :has_own_page , -> {where.not(body: nil)}
	scope :yearly, ->(year){where("extract(year from target_date) = #{year}")}
	scope :years, -> {except(:order).select("extract(year from target_date) as year").group("extract(year from target_date)").order("extract(year from target_date) desc")}
	enum release_type: {news: 0,carousel:1,ir: 2}

	def self.headline
		Release.news.limit(8)
	end

	def path
		if body
			if shop_id
				UrlHelpers.shop_details_path(shop_id)
			else
				UrlHelpers.release_path(id)
			end
		else
			url
		end
	end
end
