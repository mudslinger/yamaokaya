class Recruit::MessageController < Recruit::BaseController

	def show
		type =params[:type] if params[:type].present?
		respond_to do |format|
			format.html{render template: "recruit/message/#{type}.haml"}
			format.js{render layout: false}
		end
	end
end
