class Corporate::IrController < Corporate::BaseController

	def financial_info
		@fin = FinancialInfomation.last_5
		respond_to do |format|
			format.json{render json: @fin}
		end
	end

	private
	def layers
		base = [:corp_top,:ir_top]
		ret = {
			index: base,
			highlight: base + [:highlight],
			calender: base + [:calender],
			library: base + [:library],
			market: base + [:market],
			disclaimer: base + [:disclaimer]
		}
		ret[action_name.to_sym]
	end
end
