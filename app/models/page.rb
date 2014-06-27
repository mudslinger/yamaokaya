class Page
	include ActiveModel::Model
	include UrlHelpers
	attr_accessor(
		:url,:title,:parent,:children
	)

	def current_node(path)
		current = search_by_path path
		puts current
		# current.url
	end

	def search_by_path(path)
		return self if path == self.url.to_s
		self.children.each do |p|
			p.search_by_path(path)
		end unless self.children.nil?
	end

	def self.build(hash)
		p = Page.new(
			url: hash[:url],
			title: hash[:title]
		)
		self.parse_recursive(p,hash)
		p
	end

	def self.parse_recursive(obj,hash)
		hash[:children].each do |p|	
			c = Page.new(url: p[:url],title: p[:title])
			c.parent = obj
			obj.children = [] if obj.children.nil?
			obj.children.push c
			self.parse_recursive c,p
		end unless hash[:children].nil?
	end

	def self.sitemap(host)
		case host
		when DOMAINS[:corporate]
			self.build self.corporate
		when DOMAINS[:yamaokaya]
			self.build self.yamaokaya
		when DOMAINS[:recruit]
			nil
		end
	end


	def self.corporate
		{
			url:UrlHelpers.corp_top_path,
			title: :top,
			children:[
				{
					url: UrlHelpers.greetings_path,
					title: :greetings
				},
				{
					url: UrlHelpers.overview_path,
					title: :overview,
					children: [
						{
							url: UrlHelpers.history_path,
							title: :history
						}
					]
				},
				{
					url: UrlHelpers.business_path,
					title: :business,
					children: [
						{
							url: UrlHelpers.products_path,
							title: :products
						},
						{
							url: UrlHelpers.hospitality_path,
							title: :hospitality
						},
						{
							url: UrlHelpers.safety_path,
							title: :safety
						},
						{
							url: UrlHelpers.development_path,
							title: :development
						},
						{
							url: UrlHelpers.ict_path,
							title: :ict
						}
					]
				},
				#about
				{
					url:(UrlHelpers.about_path),
					title: :about
				},
				#snsguideline
				{
					url:(UrlHelpers.sns_guideline_path),
					title: :sns_guideline
				},
			]
		}
	end

	def self.yamaokaya
		{
			url:UrlHelpers.yamaokaya_top_path,
			title: :top,
			children:[
				#店舗
				{
					url:UrlHelpers.shop_root_path,
					title: :shops,
					children: Shop.active.map do |s|
						{
							url:UrlHelpers.shop_details_path(s.id),
							title: s.name
						}
					end
				},
				#about
				{
					url:(UrlHelpers.about_path),
					title: :about
				},
				#snsguideline
				{
					url:(UrlHelpers.sns_guideline_path),
					title: :sns_guideline
				},

			]
		}

	end
end