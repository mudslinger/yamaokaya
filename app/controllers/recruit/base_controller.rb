class Recruit::BaseController < ApplicationController
	layout 'recruit'
	before_filter :header_haml
	def header_haml
		@header_haml = if self.kind_of?(Recruit::TopController)
			'layouts/recruit/header_top' 
		else
			'layouts/recruit/header'
		end
	end
end
