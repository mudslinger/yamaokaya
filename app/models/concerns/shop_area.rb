require 'active_support'
module ShopArea
	extend ActiveSupport::Concern

	def marker_type
		self.class.name
	end

	def sprite_x
		(seq-1) % 10 * 24
	end

	def sprite_y
		(seq-1).div(10) * 56
	end

	def lat
		# if self[:lat].nil?
		# 	self[:lat] = center[0]
		# end
		# self[:lat]
		center[0]
	end

	def lng
		# if self[:lng].nil?
		# 	self[:lng] = center[1]
		# end
		# self[:lng]
		center[1]
	end

	def center
		g = children_center
		ret = g.reduce do |sum,n|
			[sum[0]+n[0],sum[1]+n[1]]
		end
		return [ret[0] / g.size,ret[1] / g.size] unless ret.nil?
		[nil,nil]
	end

	def bounds
		g = children_center
		return {s: 0,w: 0,n: 0,e:0} if g.empty?
		s_end = g.max do |a,b|
			a[0] <=> b[0]
		end[0]
		w_end = g.min do |a,b|
			a[1] <=> b[1]
		end[1]
		n_end = g.min do |a,b|
			a[0] <=> b[0]
		end[0]
		e_end = g.max do |a,b|
			a[1] <=> b[1]
		end[1]
		{s: s_end-0.5,w: w_end+0.5,n: n_end+0.5,e:e_end+0.5}
	end

	def has_shops?
		shops.size != 0
	end
end