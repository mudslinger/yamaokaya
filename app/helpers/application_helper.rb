module ApplicationHelper
	#コンテキストに合わせたI18n.t
	def tt(key,options: {})

		options[:scope] = [controller_name,action_name]
		I18n.t key,options 
	end

	def carousel_body(txt)
		raw render type: :haml,inline: txt
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
		image_tag "http://maps.googleapis.com/maps/api/staticmap?#{query_string}", alt: location.name,class: 'img-rounded',style:'width:95%'
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

		url = img_path(size: size.to_s,file: path)

		meta = Rails.cache.read(image_url: url)
		meta = {
			assets_url: "//assets#{Digest::MD5.hexdigest(url).hex % 8}.yamaokaya.com#{url}"
		} unless meta

		#params = {src: meta[:assets_url],alt: alt,title: title, class: cls}
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

		image_tag meta[:assets_url],params

	end

	def ln(str)
		#TODO ARと連動・要キャッシュ・IDに変換
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
	    image_tag "http://maps.googleapis.com/maps/api/staticmap?#{query_string}", :alt => shop.name,class: 'img-rounded'
	end
end
