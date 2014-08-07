class Corporate::IrController < Corporate::BaseController
	ssl_required :all
	def financial_info
		@fin = FinancialInfomation.last_5
		respond_to do |format|
			format.json{render json: @fin}
		end
	end

end
