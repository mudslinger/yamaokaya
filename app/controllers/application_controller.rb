class ApplicationController < ActionController::Base
	include ::SslRequirement
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :detect_device_format
	before_filter :set_title

	rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :render_404

	def render_404
		render(
			template: "application/404",
			layout: domain_layout,
			status: 404
		)
	end

	private
	def detect_device_format
		case request.user_agent
		when /iPad/i
			request.variant = :tablet
		when /iPhone/i
			request.variant = :phone
		when /Android/i && /mobile/i
			request.variant = :phone
		when /Android/i
			request.variant = :tablet
		when /Windows Phone/i
			request.variant = :phone
		end
		@variant = request.variant
	end

	def domain_layout
		DOMAINZ[request.host].to_s
		# DOMAINS.select do |k,v|
		# 	v == request.host
		# end.keys.first.to_s
	end

	def set_title
		sitemap = Page.sitemap(request.host)
		begin
			@current_page = sitemap.current_node(request.path_info)
			@current_page = Page.new(title: "山岡家") if @current_page.nil?
		rescue
			@current_page = Page.new(title: "山岡家")
		end
	end

	# def auth
	# 	if request.host == 'www2014.yamaokaya.com' || request.host == 'maruchiyo2014.yamaokaya.com' || request.host == 'recruit2014.yamaokaya.com'
	# 		authenticate_or_request_with_http_basic do |user,pass|
	# 			user == 'men' && pass == 'katame'
	# 		end
	# 	end
	# end


end
