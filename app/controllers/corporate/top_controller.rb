class Corporate::TopController < Corporate::BaseController

	def index
		IrTopic.find_all
	end
	def greetings;end

	def vision;end
end
