class Recruit::BaseController < ApplicationController
	layout 'recruit'
	before_filter :header_haml
	ssl_required :all
	def header_haml
		@header_haml = if self.kind_of?(Recruit::TopController)
			'recruit_header_top' 
		else
			'recruit_header'
		end
	end
end
