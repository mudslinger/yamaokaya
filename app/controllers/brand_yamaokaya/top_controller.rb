class BrandYamaokaya::TopController < BrandYamaokaya::BaseController
	def index
		@headlines = Release.headline
	end

end
