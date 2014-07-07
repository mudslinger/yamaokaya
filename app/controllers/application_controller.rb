class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :detect_device_format
	before_filter :auth
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
	end

	def domain_layout
		DOMAINS.select do |k,v|
			dmn = (request.subdomain.empty? ? '' : request.subdomain + '.') + request.domain
			v == dmn
		end.keys.first.to_s
	end

	private
	def auth
		dmn = (request.subdomain.empty? ? '' : request.subdomain + '.') + request.domain

		if dmn == 'www2014.yamaokaya.com' || dmn == 'maruchiyo2014.yamaokaya.com' || dmn == 'recruit2014.yamaokaya.com'
			authenticate_or_request_with_http_basic do |user,pass|
				user == 'men' && pass == 'katame'
			end
		end
	end
end
