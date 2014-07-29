class Page
	include ActiveModel::Model

	@@i18n_handler = Class.new do |kls|
					def kls.call(exception, locale, key, options)
	    				raise exception if exception
					end
	end

	attr_accessor(
		:url,:title_key,:title,:parent,:children,:all_children,:parent
	)

	#パス収集メソッド
	def collect_all_children(c)
		c[@url] = self
		c["#{@url}.html"] = self
		@children.each do |p|
			p.collect_all_children(c)
		end unless @children.nil?
	end

	def current_node(path)
		if @all_children.nil?
			@all_children = {}
			collect_all_children(@all_children)
		end
		@all_children[path]
	end

	def search_by_path(path,&block)

		@children.each do |p|
			yield p.url
		end unless @children.nil?

	end

	def title
		case @title
		when Symbol
			I18n.t :main,scope: [:titles,@title]
		when String
			@title
		end		
	end

	def subtitle
		case @title
		when Symbol
			I18n.t :sub,scope: [:titles,@title]
		when String
			nil
		end	
	end

	def short_title
		case @title
		when String
			@title
		when Symbol
			begin
				I18n.t :short,scope: [:titles,@title],exception_handler: @@i18n_handler
			rescue
				I18n.t :main,scope: [:titles,@title]
			end

		end	
	end

	def tree_from_root
		p = self
		tree = []
		until p.parent.nil?
			tree.unshift p
			p = p.parent
		end
		tree.unshift p
		tree
	end

	def self.sitemap(host)
		case host
		when DOMAINS[:corporate]
			return Rails.cache.fetch(domain: host) do
				ret = self.corporate
				to_kindred ret
				ret
			end
		when DOMAINS[:yamaokaya]
			return Rails.cache.fetch(domain: host) do
				ret = self.yamaokaya
				to_kindred ret
				ret
			end
		when DOMAINS[:recruit]
			return Rails.cache.fetch(domain: host) do
				ret = self.recruit
				to_kindred ret
				ret
			end
		end
	end

	def self.to_kindred(page)
		page.children.each do |c|
			c.parent = page
			to_kindred(c) unless c.children.nil?
		end unless page.children.nil?
	end

	def self.recruit
		Page.new(
			url:UrlHelpers.recruit_top_path,
			title: :recruit_top,
			children:[
				Page.new(
					title: :graduates,
					children:[
						Page.new(
							url: UrlHelpers.message_graduates_path,
							title: :message_graduates
						),
						Page.new(
							url: UrlHelpers.interview_graduates_path,
							title: :interview_graduates
						),
						Page.new(
							url: UrlHelpers.requirements_graduates_path,
							title: :requirements_graduates
						),
						Page.new(
							url: UrlHelpers.entries_path(:graduates2),
							title: :entries
						)
					]
				),
				Page.new(
					title: :career,
					children:[
						# Page.new(
						# 	url: UrlHelpers.message_career_path,
						# 	title: :message_career
						# ),
						# Page.new(
						# 	url: UrlHelpers.interview_career_path,
						# 	title: :interview_career
						# ),
						Page.new(
							url: UrlHelpers.requirements_career_path,
							title: :requirements_career
						),
						Page.new(
							url: UrlHelpers.entries_path(:career),
							title: :entries
						)
					]
				),
				Page.new(
					title: :pa,
					children:[
						# Page.new(
						# 	url: UrlHelpers.message_pa_path,
						# 	title: :message_pa
						# ),
						# Page.new(
						# 	url: UrlHelpers.interview_pa_path,
						# 	title: :interview_pa
						# ),
						Page.new(
							url: UrlHelpers.requirements_pa_path,
							title: :requirements_pa
						),
						Page.new(
							url: UrlHelpers.entries_path(:pa),
							title: :entries
						)
					]
				),
			]
		)
	end
	def self.corporate
		Page.new(
			url: UrlHelpers.corp_top_path,
			title: :corp_top,
			children:[
				Page.new(
					url: UrlHelpers.greetings_path,
					title: :greetings
				),
				Page.new(
					title: :company,
					children:[
						Page.new(
							url: UrlHelpers.overview_path,
							title: :overview
						),
						Page.new(
							url: UrlHelpers.history_path,
							title: :history
						),
					]
				),
				Page.new(
					title: :business,
					children:[
						Page.new(
							url: UrlHelpers.products_path,
							title: :products
						),
						Page.new(
							url: UrlHelpers.hospitality_path,
							title: :hospitality
						),
						Page.new(
							url: UrlHelpers.safety_path,
							title: :safety
						),
						Page.new(
							url: UrlHelpers.development_path,
							title: :development
						)
					]
				),
				Page.new(
					url: UrlHelpers.ir_top_path,
					title: :ir_top,
					children:[
						Page.new(
							url: UrlHelpers.highlight_path,
							title: :highlight
						),
						Page.new(
							url: UrlHelpers.library_path,
							title: :library
						),
						Page.new(
							url: UrlHelpers.calender_path,
							title: :calender
						),
						Page.new(
							url: UrlHelpers.disclaimer_path,
							title: :disclaimer
						),
						Page.new(
							url: UrlHelpers.market_path,
							title: :market
						)
					]
				),
				Page.new(
					url: UrlHelpers.property_path,
					title: :property
				),
				Page.new(
					url: UrlHelpers.about_path,
					title: :about
				),
				Page.new(
					url: UrlHelpers.sitemap_path,
					title: :sitemap
				),
				Page.new(
					url: UrlHelpers.sns_guideline_path,
					title: :sns_guideline
				)
			]
		)
	end

	def self.yamaokaya
		Page.new(
			url:UrlHelpers.yamaokaya_top_path,
			title: :brand_top,
			children: [
				Page.new(
					url:UrlHelpers.shop_root_path,
					title: :shops,
					children: Region.has_shops.map do |r|
						Page.new(
							url:  UrlHelpers.shop_root_path(anchor: r.id),
							title: r.name,
							children: r.prefectures.has_shops.map do |p|
								p.areas.map do |area|
									Page.new(
										url:  UrlHelpers.shop_root_path(anchor: area.id),
										title: p.name + area.name,
										children: area.shops.map do |s|
											Page.new(
												url: UrlHelpers.shop_details_path(s.id),
												title: s.long_name
											)
										end
									)
								end
							end.flatten
						)
					end << (
						#閉店店舗を追加
						Page.new(
							title: '閉店済み',
							children: Shop.inactive.map do |s|
								Page.new(
									url: UrlHelpers.shop_details_path(s.id),
									title: s.long_name
								)
							end
						)
					)
				),
				Page.new(
					title: :menus,
					children:[
						Page.new(
							url: UrlHelpers.menu_categorized_path(:regular),
							title: :regular,
							children: Menu.regular.map do |m|
								Page.new(
									url:UrlHelpers.menu_details_path(m.id),
									title: m.name
								)
							end
						),
						Page.new(
							url: UrlHelpers.menu_categorized_path(:std),
							title: :std,
							children: Menu.std.map do |m|
								Page.new(
									url:UrlHelpers.menu_details_path(m.id),
									title: m.name
								)
							end
						),
						Page.new(
							url: UrlHelpers.menu_categorized_path(:limited),
							title: :limited,
							children: Menu.limited.map do |m|
								Page.new(
									url:UrlHelpers.menu_details_path(m.id),
									title: m.name
								)
							end
						),
						Page.new(
							url: UrlHelpers.menu_categorized_path(:set),
							title: :set,
							children: Menu.set.map do |m|
								Page.new(
									url:UrlHelpers.menu_details_path(m.id),
									title: m.name
								)
							end
						)
					]
				),
				Page.new(
					url: UrlHelpers.releases_path,
					title: :releases,
					children: Release.news.map do |m|
						Page.new(
							url: m.path,
							title: m.title
						)
					end
				),
				Page.new(
					url: UrlHelpers.feedbacks_path,
					title: :feedbacks
				),
				Page.new(
					url: UrlHelpers.about_path,
					title: :about
				),
				Page.new(
					url: UrlHelpers.sitemap_path,
					title: :sitemap
				),
				Page.new(
					url: UrlHelpers.sns_guideline_path,
					title: :sns_guideline
				),
				Page.new(
					url: UrlHelpers.mag_faq_path,
					title: :mag_faq
				)
			]
		)
	end
end