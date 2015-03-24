class BrandYamaokaya::TopController < BrandYamaokaya::BaseController

	def index
		@headlines = Release.headline
		@carousels = Release.carousel
	end

end
