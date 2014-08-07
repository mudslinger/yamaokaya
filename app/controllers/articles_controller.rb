class ArticlesController < ApplicationController

	layout :domain_layout
	ssl_required :all

	def sitemap
		@site = Page.sitemap(request.host)
	end
end
