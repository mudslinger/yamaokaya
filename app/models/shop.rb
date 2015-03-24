class Shop < ActiveRecord::Base

	default_scope -> {
		order(:id)
	}

	scope :active, -> {
		where("(current_timestamp between inauguration and close)")
	}
	scope :inactive, -> {
		where.not("(current_timestamp between inauguration and close)")
	}

	scope :by_zoom, ->(zoom) {
		where("#{zoom} >= shops.start_shows")
	}
	
	scope :with_higher, ->{
		includes(:area => {:prefecture => :region})
	}

	scope :nearby, ->(lat,lng) {
		where.not(lat: lat).where.not(lng:lng).reorder(
			"SQRT(power(lat - #{lat},2)+power(lng - #{lng},2))"
		).limit(4)
	}


	belongs_to :area
	has_many :releases,->{where('current_timestamp between start_shows and end_shows')},inverse_of: :shop
	delegate :prefecture, to: :area, allow_nil: false
	delegate :region, to: :prefecture, allow_nil: false

	def long_name
		ret = closed? ? '[閉店]' : ''
		#ret += before_opened? ? '[開店前]' : ''
		ret += "ラーメン山岡家 #{self[:name]}"
		ret
	end


	def closed?
		#not DateTime.now.between?(inauguration,close)
		close < DateTime.now
	end

	def before_opened?
		inauguration > DateTime.now
	end
	def marker_type
		self.class.name
	end

	def nearby
		Shop.nearby(lat,lng).active
	end

	def sprite_x
		(seq-1) % 10 * 49
	end

	def sprite_y
		(seq-1).div(10) * 57
	end

	def center
		[lat,lng]
	end

	def end_shows
		100
	end

	def shop_hours
		if allnight?
			encode_shop_hour(0)
		elsif alldayssame?
			encode_shop_hour(sunday)
		else 
			Hash[
				{
					'日' => sunday,
					'月' => monday,
					'火' => tuesday,
					'水' => wednesday,
					'木' => thursday,
					'金' => friday,
					'土' => saturday
				}.group_by do |k,v|
					v
				end.map do |k,v|
					[v.map do |k,v|
						k
					end ,encode_shop_hour(k)]
			end
			]
		end
	end

	def shop_status
		puts name
		st = shop_time(Time.now - 6.hours)
		puts st
		if now_open?
			{status: 'success',text: '営業中'}
		elsif st == 281474976710655
			{status: 'danger',text: '休止中'}
		else
			{status: 'warning',text: I18n.l(encode_shop_hour(st)[0].begin,format: :short_time) + '開店'}
		end
	end

	def shop_hours_human
		sh = shop_hours
		fmt = '%p%I:%M'
		if sh.is_a?(Array)
			return sh.map do |h|
				if h.max - h.min == 24.hours
					"24時間営業"
				else
					"#{h.min.strftime(fmt)} 〜 #{h.max.strftime(fmt)}"
				end
			end
		else
			sh.sort do |a,b|
				b[0].size <=> a[0].size
			end.map do |k,v|
				if k.size > 4 
					""
				else
					"#{k.join(',')}:"
				end + v.map do |h|
					if h.max - h.min == 24.hours
							"24時間営業"
					else
						"#{h.min.strftime(fmt)} 〜 #{h.max.strftime(fmt)}"
					end
				end.join(',')
			end
		end
	end

	def allnight?
		sunday + monday + tuesday + wednesday + thursday + friday + saturday == 0
	end

	def alldayssame?
		[monday,tuesday,wednesday,thursday,friday,saturday].all? do |o|
			o == sunday
		end
	end
	def now_open?
		return true if allnight?
		dow = shop_time(Time.now - 6.hours)
		encode_shop_hour(dow).any? do |h|
			Time.now.between?(h.begin,h.end)
		end
	end

	def mail_addrs
		{
		  group: "s#{self.id}@yamaokaya.com",
		  manager: "s#{self.id}-man@yamaokaya.com",
		  sv: "s#{self.id}-sv@yamaokaya.com"
		}
	end

	def addrs
		#まずは都道府県を削除
		wo_pref = address.gsub(prefecture.name,'')
		city = wo_pref.scan(/^[^市町]+[市|町]/)[0]
		addr1 = wo_pref.gsub(city,'').strip
		{
			pref: prefecture.name,
			city: city,
			addr1: addr1
		}
	end

	def self.to_business_location
		CSV.generate do |csv|
			csv << %w(店舗コード 名前 住所1 住所2 市/区 地区 都道府県 国 郵便番号 電話番号1 ホームページ カテゴリ 営業時間 緯度 経度 画像 説明 メール 電話番号2 携帯電話番号 FAX 支払い方法)
			with_higher.active.each do |shop|
				csv << [
					shop.id,
					"ラーメン山岡家 #{shop.name}",
					shop.addrs[:addr1],
					'',
					shop.addrs[:city],
					'',
					shop.addrs[:pref],
					'JP',
					"%03d-%04d" % [shop.postal_code.to_i.div(10000),shop.postal_code.to_i % 10000],
					shop.phone,
					UrlHelpers.shop_details_url(shop.id),
					'ラーメン屋',
					shop.shop_time_for_google,
					shop.lat,
					shop.lng,
					'', #画像
					'', #説明
					'', #メール
					'', #電話番号2
					'', #携帯電話番号
					shop.phone, #fax
					'cash', #支払い方法	
				]
			end
		end
	end

	def shop_time_for_google
		ret = ''
		[
			sunday,
			monday,
			tuesday,
			wednesday,
			thursday,
			friday,
			saturday
		].each_with_index do |d,i|
			sh = encode_shop_hour(d)[0]
			ret+= "#{i+1}:#{sh.begin.strftime('%H:%M')}:#{sh.end.strftime('%H:%M')}"
			ret+= ',' if i < 6
		end
		ret
	end

	private
	def shop_time(d)
		dow = if d.sunday? then sunday
		elsif d.monday? then monday
		elsif d.tuesday? then tuesday
		elsif d.wednesday? then wednesday
		elsif d.thursday? then thursday
		elsif d.friday? then friday
		elsif d.saturday? then saturday			
		end
		dow
	end

	def encode_shop_hour(hour)
		t = (Time.now- 6.hours).change hour:6
		return [(t..(t + 1.day))] if hour == 0
		(24.hours / 30.minutes).times.map do |n|
			[n,(hour & 1 << n) == 0]
		end.inject([]) do |ret,v|
			ret << (t + (v[0]*30).minutes..t + (v[0]*30+30).minutes) if ret.empty? && v[1]
			if v[1] && !ret.empty?
				if ret.last.max >= t + (v[0]*30).minutes 
					ret[ret.length-1] = (ret.last.min..(t + (v[0]*30+30).minutes))
				else
					ret << (t + (v[0]*30).minutes..t + (v[0]*30+30).minutes)
				end
			end
			ret
		end

	end

end
