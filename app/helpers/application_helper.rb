module ApplicationHelper

	def is_phone?
		(request.variant || []).include?(:phone)
	end

	def is_tablet?
		(request.variant || []).include?(:tablet)
	end
	#コンテキストに合わせたI18n.t
	def tt(key,options: {})

		options[:scope] = [controller_name,action_name]
		I18n.t key,options 
	end

	def release_body(txt)
		carousel_body txt
	end
	def carousel_body(txt)
		begin
			raw render type: :haml,inline: txt
		rescue
			''
		end
	end

	def static_map_for(location, options = {})
		params = {
			:center => [location.lat, location.lng].join(","),
			:zoom => location.zoom,
			:size => "240x180",
			:markers => [location.lat, location.lng].join(","),
			:sensor => true
		}.merge(options)

		query_string =  params.map{|k,v| "#{k}=#{v}"}.join("&")
		image_tag(
			"http://maps.googleapis.com/maps/api/staticmap?#{query_string}", 
			alt: location.name,
			class: 'shop-image img-rounded'
		)
	end



	#山岡家専用img_tag
	def ymage_tag(
		path,
		size: :origin,
		alt: nil,
		longdesc: nil,
		name: nil,
		ismap: false,
		usemap: nil,
		align: nil,
		width: nil,
		height: nil,
		id: nil,
		cls: nil,
		title: nil,
		style: nil,
		dir: nil,
		lang: nil
	)

		meta = find_img_meta(img_path(size: size.to_s,file: path))
		params = {
			alt: alt,
			longdesc: longdesc,
			name: name,
			ismap: false,
			usemap: usemap,
			align: align,
			width: width,
			height: height,
			id: id,
			class: cls,
			title: title,
			style: style,
			dir: dir,
			lang: lang
		}
		#画像のサイズがゲット出来ている場合
		# params[:width] = meta[:width] if meta[:width]
		# params[:height] = meta[:height] if meta[:height]

		image_tag URI.unescape(meta[:assets_url]),params

	end

	#山岡家店舗用image_tag
	def ymage_tag_for_shop(
		shop,
		size: :origin,
		alt: nil,
		longdesc: nil,
		name: nil,
		ismap: false,
		usemap: nil,
		align: nil,
		width: nil,
		height: nil,
		id: nil,
		cls: nil,
		title: nil,
		style: nil,
		dir: nil,
		lang: nil,
		showmap: true
	)

		meta = find_img_meta(img_path(size: size.to_s,file: "images/shops/photos/#{shop.id}.jpg"))
		params = {
			alt: alt,
			longdesc: longdesc,
			name: name,
			ismap: false,
			usemap: usemap,
			align: align,
			width: width,
			height: height,
			id: id,
			class: cls,
			title: title,
			style: style,
			dir: dir,
			lang: lang
		}
		#メタデータにファイル無しフラグが設定されている場合 staticmapを表示
		if meta[:notfound] == true && showmap == true
		    mapparams = {
		      :center => shop.center.join(","),
		      :zoom => shop.zoom,
		      :size => size || "200x300",
		      :markers => shop.center.join(","),
		      :sensor => true
		    }
		    query_string = mapparams.map{|k,v| "#{k}=#{v}"}.join("&")
		    meta[:assets_url] = "http://maps.googleapis.com/maps/api/staticmap?#{query_string}"
	 	end
	    if meta[:notfound] == true && showmap == false
	    	''
	    else
			image_tag URI.unescape(meta[:assets_url]),params
		end
	end

	def find_img_meta(url)
		meta = Rails.cache.read(image_url: url)
		meta || {
			assets_url: "//assets#{Digest::MD5.hexdigest(url).hex % 8}.yamaokaya.com#{url}",
			notfound: false
		}
	end
	def ln(str)

		cache do
			shops = Shop.active
			shops.each do |s|
				str = str.gsub(
					s.name,
					link_to(s.name,shop_details_url(s.id),target: '_blank')
				)
			end
			return raw str
		end
		
	end

	def mf(num)
		if num.nil?
			"--"
		else
			number_to_currency num,local: :ja
		end
	end

	def eat_bread(obj)
		breadcrumb(render partial:'layouts/corporate/breadcrumb',locals:{list: obj})
	end

	def enums_options(enums:enums,key:key,selected:selected)
		options_for_select(
			enums.collect do |s|
				[I18n.t(s[0],scope: [:enums,key]), s[0]]
			end,
			selected: selected)
	end

	def static_map_for_shop(shop,options = {})
	    params = {
	      :center => shop.center.join(","),
	      :zoom => shop.zoom,
	      :size => "400x300",
	      :markers => shop.center.join(","),
	      :sensor => true
	      }.merge(options)
	 
	    query_string =  params.map{|k,v| "#{k}=#{v}"}.join("&")
	    image_tag(
	    	"http://maps.googleapis.com/maps/api/staticmap?#{query_string}",
	    	:alt => shop.name,
	    	class: %w(shop-image img-rounded)
	    )
	end
end
