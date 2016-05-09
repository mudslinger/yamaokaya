class Recruit::AdManagementController < Recruit::BaseController
	JSON_ATTR = [:id,:name,:wage,:ad_sunday,:ad_monday,:ad_tuesday,:ad_wednesday,:ad_thursday,:ad_friday,:ad_saturday,:ad_comment]
	JSON_EXCEPT_ATTR = []
	before_filter :basic_auth,only: [:show,:update]
	def basic_auth
    authenticate_or_request_with_http_basic do |user,pass|
      user == 'yamaokaya' && pass == 'menkatame'
    end
  end

	def show

	end

	def update
		target = Shop.find(params[:shop_id].to_i) if params[:shop_id]
		# target.wage = params[:wage]
		week = (params[:ad_week] || [0])
		.map {|item| item.to_i}
		.reduce(0) {|memo,item| memo + item}
		time = (params[:ad_time] || [0])
		.map {|item| item.to_i}
		.reduce(0) {|memo,item| memo + item}

		target.update_attributes(
			ad_week: week,
			ad_time: time,
			wage: ((params[:wage].to_i.div(10)) * 10 || 0),
			ad_comment: params[:ad_comment]
		) if target
    respond_to{ |format|
      format.json{
        render(
          json: target,
          methods: JSON_ATTR
        )
      }
    }
	end
end
