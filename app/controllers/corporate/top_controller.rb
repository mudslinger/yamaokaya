class Corporate::TopController < Corporate::BaseController
	ssl_required :all
	def index
		IrTopic.find_all
	end
	def greetings;end
end
