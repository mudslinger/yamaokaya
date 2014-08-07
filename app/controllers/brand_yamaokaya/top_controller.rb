class BrandYamaokaya::TopController < BrandYamaokaya::BaseController
	ssl_required :all
	def index
		@headlines = Release.headline
		@carousels = Release.carousel
	end

end
