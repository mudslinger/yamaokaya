module ApplicationHelper
	#コンテキストに合わせたI18n.t
	def tt(key)
		I18n.t key,scope: [controller_name,action_name]
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

		image_tag url,params

	end

	def ln(str)
		#TODO ARと連動・要キャッシュ・IDに変換
		kwz = /南2条店|琴似店|手稲店|藤野店|太平店|清田店|東雁来店|恵庭店|北広島店|苫小牧柳店|岩見沢店|新道店|旭川高砂台店|樽川店|釧路店|北見店|野幌店|帯広店|旭川永山店|上磯店|滝川店|苫小牧糸井店|室蘭店|美幌店|伊達店|新すすきの店|千歳店|八雲店|苫小牧船見店|月寒店|大谷地店|帯広南店|狸小路4丁目店|朝里店|函館鍛冶店|釧路町店|網走店|稚内店|牛久店|つくば店|阿見店|小山駅南町店|小山田間店|宇都宮鶴田店|土浦店|壬生店|岩瀬店|結城店|春日部店|宇都宮長岡店|谷田部店|柏店|水戸南店|太田店|ひたちなか店|成田店|足利店|千葉中央区店|木更津店|高崎西店|千葉花見川区店|伊勢崎宮子店|瑞穂店|君津店|吹上店|狭山店|高崎倉賀野店|前橋亀里店|名取店|高崎中尾店|富士店|熊谷店|仙台泉区店|いわき店|上尾店|厚木店|石巻店|鷲宮店|岐阜瑞穂店|大垣店|佐野店|野田店|笛吹店|さいたま宮前店|浜松有玉店|福島矢野目店|浜松入野店|守谷店|山形青田店|水戸内原店|相模原店|豊橋下地店|大口店|桑名店|さいたま丸ヶ崎店|鈴鹿店|平塚店|八千代店|東千葉店|つくば中央店|浜松薬師店|高田馬場店|伊奈町店|成田飯仲店|沼津柿田川店|かすみがうら店|音羽蒲郡店|水戸城南店|新宿歌舞伎町店|池袋西口店|日立滑川店|越谷レイクタウン店|長野南長池店|東松山店|山梨甲斐店|長野篠ノ井店|東金店|日立東金沢店|名古屋宝神店|千葉若葉区店|千葉鎌ヶ谷店|千葉茂原店|岩手盛岡店|千葉佐倉店|秋田仁井田店|松本店|愛知刈谷店|宮城野店|フォレスト河口湖店|中荻野店|郡山店|富士宮店|浜松南区店|弘前店|高岡店|テクノポリスセンター店|金沢森戸店|明石店|岸和田店|京都八幡店|北九州店|熊本店/
		tmp = str.gsub(kwz) do |shop|
			link_to shop,shop_details_path(key: shop),host:'yam.com'
		end.to_s
		raw tmp
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
