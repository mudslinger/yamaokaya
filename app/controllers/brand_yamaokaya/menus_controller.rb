class BrandYamaokaya::MenusController < BrandYamaokaya::BaseController
	ssl_required :all
	def categorized
		category = params[:category] if  params[:category].present?
		category = category.to_sym || :regular
		if Menu.respond_to?(category)
			@menus = Rails.cache.fetch(menu: {category: category})do 
				Menu.send(category)
			end
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
