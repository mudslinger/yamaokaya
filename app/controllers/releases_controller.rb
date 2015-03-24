class ReleasesController < ApplicationController
	layout :domain_layout

	def release
		@release = Release.news.find(params[:id]) if params[:id].present?
	end

	def releases
		@releases = Release.news
	end
end
