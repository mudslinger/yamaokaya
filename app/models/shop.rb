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
		ret += "ラーメン山岡家 #{self[:name]}"
		ret
	end


	def closed?
		not DateTime.now.between?(inauguration,close)
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
		st = shop_time(Time.now - 6.hours)
		if now_open?
			{status: 'success',text: '営業中'}
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
					puts 'yaru'
					puts ret.last.max
					puts (t + (v[0]*30).minutes..t + (v[0]*30+30).minutes)
					ret << (t + (v[0]*30).minutes..t + (v[0]*30+30).minutes)
				end
			end
			ret
		end

	end
	# def encode_shop_hour(hour)
	# 	t = (DateTime.now- 6.hours).change hour:6
	# 	return [(t..t+1.days)] if hour == 0
	# 	h = hour | 1<<48
	# 	48.times.map do |n|
	# 		[n,h & 1 << n ==0, h & 1 << n+1 == 0]
	# 	end.select do |i|
	# 		i[1] != i[2] || i[0] == 0
	# 	end.each_cons(2).map do | i,j|
	# 		puts "#{i} -- #{j}"
	# 		{range: t + (i[0]*30 + (i[0] == 0 ? 0 : 30)).minutes..t + (j[0]*30+30).minutes,on: i[2]}
	# 	end.select do |o|
	# 		o[:on]
	# 	end.map do |o|
	# 		o[:range]
	# 	end
	# end


end
