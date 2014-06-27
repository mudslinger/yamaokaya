class ArticlesController < ApplicationController

	layout :domain_layout

	def sitemap
		@site = Page.sitemap request.domain
	end

	def domain_layout
		case request.domain
		when DOMAINS[:corporate]
			'corporate'
		when DOMAINS[:yamaokaya]
			'yamaokaya'
		when DOMAINS[:recruit]
			'recruit'
		end
	end
end
