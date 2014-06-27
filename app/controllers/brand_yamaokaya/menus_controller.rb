class BrandYamaokaya::MenusController < BrandYamaokaya::BaseController
	def categorized
		category = params[:category] if  params[:category].present?
		category = :regular || category.to_sym
		if Menu.respond_to?(category)
			@menus = Menu.send(category)
			puts @menus
		end
	end

	def details
		id = params[:id] if params[:id].present?
		@menu = Menu.find(id)
		respond_to do |format|
			format.html{render 'details.haml'}
			format.js{render 'details.coffee',layout: false}
		end
	end
end
