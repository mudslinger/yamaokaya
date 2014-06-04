class Corporate::BaseController < ApplicationController
	layout 'corporate'
	before_filter :eat_bread
	def eat_bread

		@layers = if layers.nil? then [] else layers end
	end

	private
	def layers
		[]
	end
end
