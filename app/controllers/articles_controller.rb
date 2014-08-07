class ArticlesController < ApplicationController

	layout :domain_layout


	def sitemap
		@site = Page.sitemap(request.host)
	end
end
