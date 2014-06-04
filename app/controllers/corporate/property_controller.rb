class Corporate::PropertyController < Corporate::BaseController
	private
	def layers
		base = [:corp_top,:property]
		ret = {
			development: [:corp_top,:property]
		}
		ret[action_name.to_sym]
	end
end
