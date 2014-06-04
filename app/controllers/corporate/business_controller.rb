class Corporate::BusinessController < Corporate::BaseController
	private
	def layers
		base = [:corp_top,:business]
		ret = {
			yamaokaya: base,
			products: base + [:products],
			hospitality: base  + [:hospitality],
			safety: base  + [:safety],
			development: base  + [:development],
			ict: base  + [:ict]
		}
		ret[action_name.to_sym]
	end
end
