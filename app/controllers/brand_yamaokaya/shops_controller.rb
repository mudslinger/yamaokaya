class BrandYamaokaya::ShopsController < BrandYamaokaya::BaseController

	protect_from_forgery except: :shops

	def details
		@shop = Shop.find(params[:key]) if params[:key].present?
	end

	def my_business_locations
		respond_to do |format|
			format.csv{send_data Shop.to_business_location}
		end
	end

	def jobop
		@shop = Shop.find(params[:key]) if params[:key].present?
		@banner = params[:banner] if params[:key].present?
		JobopLog.new(shop_id: @shop.id,banner_number: @banner,ip_addr: request.remote_ip()).save()
		puts @shop.id,@banner
		redirect_to(@shop.jobop_url,status: :see_other) if @shop.jobop_url
	end


	def shops
		Shop.cache do
			@regions = Rails.cache.fetch(:regions_has_shops) do
				Region.has_shops
			end
			respond_to do |format|
				format.html{render template: 'brand_yamaokaya/shops/shops.haml'}
				format.js{render layout: false}
			end
		end
	end

	def big_map
		respond_to do |format|
			format.html{render template: 'brand_yamaokaya/shops/big_map.haml',layout:false}
		end
	end

	def markers
		zoom = params[:zoom] if params[:zoom].present?
		zoom = zoom || 0
		@ret = Rails.cache.fetch(markers: {zoom: zoom}) do
			regions = Region.has_shops.by_zoom(zoom)
			prefectures = Prefecture.has_shops.by_zoom(zoom)
			areas = Area.has_shops.by_zoom(zoom)
			shops = Shop.active.by_zoom(zoom)
			((regions + prefectures + areas).map do |v|
				ret = !v.kind_of?(Region) && v.shops.size == 1 ? v.shops.first : v
				ret.start_shows = v.start_shows unless v == ret
				ret
			end  + shops)
		end

		additional_attr = [:marker_type,:sprite_x,:sprite_y,:bounds,:start_shows,:end_shows,:lat,:lng]
		except_attr = [:created_at,:updated_at,:address,:phone,:furigana,:gname,:postal_code,:landmarks,:inauguration,:close,
			:sunday,:monday,:tuesday,:wednesday,:thursday,:friday,:saturday,
			:seats_at_counter,:booths,:park_caps,:truck_park_caps
		]
		respond_to do |format|
			format.json{
				render(
					json: @ret,
					methods: additional_attr,
					except: except_attr
				)
			}
		end
	end

	def nerby_shops
		lat = params[:lat] if params[:lat].present?
		lng = params[:lng] if params[:lng].present?
		@shops = lat && lng ? Shop.nearby(lat,lng) : []
		additional_attr = [:marker_type,:sprite_x,:sprite_y,:bounds,:start_shows,:end_shows]
		respond_to do |format|
			format.json{
				render(
					json: @shops,
					methods: additional_attr
				)
			}
			format.js{render 'nerby_shops.coffee',layout: false}
		end
	end

	def children

		current_key = params[:key] if params[:key].present?
		current_type = params[:type].to_sym if params[:type].present?
		case current_type || :japan
			when :region
				@children = Region.has_shops.find(current_key).prefectures.map do |p|
					if p.shops.size == 1
						p.shops.first
					else
						p
					end
				end
				#@children = Prefecture.has_shops.sorted.by_region(current_key)
			when :prefecture
				tmp = Prefecture.has_shops.find(current_key).areas
				if tmp.size < 2
					@children = Prefecture.has_shops.find(current_key).shops
				else
					@children = tmp.map do |a|
						if a.shops.size == 1
							a.shops.first
						else
							a
						end
					end
				end
				# @children = Area.has_shops.sorted.by_prefecture(current_key)
			when :area
				@children = Area.has_shops.find(current_key).shops
			when :japan
				@children = Region.has_shops.map do |r|
					# if r.shops.size == 1
					# 	r.shops.first
					# else
					# 	r
					# end
					r
				end
		end
		puts current_type
		puts @children
		additional_attr = [:marker_type,:sprite_x,:sprite_y,:bounds]
		excepts = [:seq,:created_at,:updated_at]
		shop_excepts = excepts + [:frigana,:gname,:postal_code,:sunday,:monday,:tuesday,:wednesday,:thursday,:friday,:saturday,:inauguration,:close,:old_code,:landmarks,:phone,:address]
		respond_to do |format|
			format.json{
				render(
					json: @children,
					methods: additional_attr,
					except: excepts,
					include: {
						:prefectures => {
							methods: additional_attr,
							except: excepts,
							include: {
								:areas => {
									methods: additional_attr,
									except: excepts,
									include: {
										:shops => {
											methods: additional_attr,
											except: shop_excepts
										}
									}
								}
							}
						}
					}
				)
			}
		end
	end

	def regions
		Region.cache do
			@regions = [Region.find(params[:key])] if params[:key].present?
			@regions = Region if @regions.nil?
			respond_to do |format|
				format.json{render json: @regions}
			end
		end
	end

	def prefectures
		Prefecture.cache do
			@prefs = Prefecture.has_shops.sorted.by_region(params[:key]) if params[:key].present?
			respond_to do |format|
				format.json{render json: @prefs}
			end
		end
	end

	def areas
		Area.cache do
			@areas = [Area.find(params[:key])] if params[:key].present?
			@areas = Area if @prefs.nil?
			respond_to do |format|
				format.json{render json: @prefs}
			end
		end
	end
end
