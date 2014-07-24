class ArticlesController < ApplicationController

	layout :domain_layout

	def sitemap
		#dmn = (request.subdomain.empty? ? '' : request.subdomain + '.') + request.domain
		@site = Page.sitemap(request.host)
	end
end
