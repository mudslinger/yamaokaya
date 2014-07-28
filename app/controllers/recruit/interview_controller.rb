class Recruit::InterviewController < Recruit::BaseController

	def show
		type =params[:type] if params[:type].present?
		respond_to do |format|
			format.html{render template: "recruit/interview/#{type}.haml"}
			format.js{render layout: false}
		end
	end

	def details
		@id = params[:id] if params[:id].present?
	end

end
