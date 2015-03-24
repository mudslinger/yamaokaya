class WishedShop < ActiveRecord::Base
	belongs_to :entry
	belongs_to :shop
end
