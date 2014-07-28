class ReleasesController < ApplicationController
	layout :domain_layout

	def release
		@release = Release.news.has_own_page.find(params[:id]) if params[:id].present?
	end

	def releases
		@releases = Release.news
	end
end
