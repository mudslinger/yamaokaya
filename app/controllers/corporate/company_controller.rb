class Corporate::CompanyController < Corporate::BaseController
	private
	def layers
		base = [:corp_top,:overview]
		ret = {
			overview: base,
			history: base + [:history]	
		}
		ret[action_name.to_sym]
	end
end
