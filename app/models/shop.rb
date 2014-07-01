class Shop < ActiveRecord::Base
	geocoded_by :address, :latitude  => :lat, :longitude => :lng

	default_scope -> {
		order(:id)
	}

	scope :active, -> {
		where("(current_timestamp between [inauguration] and [close]) or (abs(datediff(d,current_timestamp,inauguration)) < 30)")
	}

	scope :by_zoom, ->(zoom) {
		where("#{zoom} >= shops.start_shows")
	}
	scope :with_higher, ->{
		includes(:area => {:prefecture => :region})
	}

	scope :nearby, ->(lat,lng) {
		where(
			"SQRT(power(lat - #{lat},2)+power(lng - #{lng},2)) <> 0" 
		).where(
			"SQRT(power(lat - #{lat},2)+power(lng - #{lng},2)) < 1" 
		).order(
			"SQRT(power(lat - #{lat},2)+power(lng - #{lng},2))"
		).limit(4)
	}

	scope :older_shops, ->(inauguration) {
		where("inauguration < '#{inauguration}'").order('inauguration desc,id desc')
	}
	belongs_to :area
	belongs_to :release
	delegate :prefecture, to: :area, allow_nil: false
	delegate :region, to: :prefecture, allow_nil: false

	def marker_type
		self.class.name
	end

	def nearby
		Shop.nearby(lat,lng).active
	end

	def seq
		Shop.older_shops(inauguration).count + 1
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

	def shop_hours_human
		sh = shop_hours
		fmt = '%p%I:%M'
		if sh.is_a?(Array)
			return sh.map do |h|
				if h.max - h.min == 1
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
					if h.max - h.min == 1
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
		today = DateTime.now
		dow =  
		if today.sunday? then sunday
		elsif today.monday? then monday
		elsif today.tuesday? then tuesday
		elsif today.wednesday? then wednesday
		elsif today.thursday? then thursday
		elsif today.friday? then friday
		elsif today.saturday? then saturday			
		end
		#TODO 日付の関係で間違った判断をするので修正
		encode_shop_hour(dow).any? do |h|
			h.include?(today)
		end
	end
	private
	def encode_shop_hour(hour)
		t = DateTime.now.change hour:6
		return [(t..t+1.days)] if hour == 0
		h = hour | 1<<48
		48.times.map do |n|
			[n,h & 1 << n ==0, h & 1 << n+1 == 0]
		end.select do |i|
			i[1] != i[2] || i[0] == 0
		end.each_cons(2).map do | i,j|
			puts "#{i} -- #{j}"
			{range: t + (i[0]*30 + (i[0] == 0 ? 0 : 30)).minutes..t + (j[0]*30+30).minutes,on: i[2]}
		end.select do |o|
			o[:on]
		end.map do |o|
			o[:range]
		end
	end


end
