class Menu < ActiveRecord::Base

	default_scope -> {order(:id,:category,:subcategory,:taste,:ingredients)}
	default_scope -> {where('(current_timestamp between start_sells and end_sells)')}
	
	has_many :allergen_labellings

	enum category: {regular:0, std:1, limited:2,set:3}
	enum subcategory: {noodle:0,side:1,topping:2,drink:3,complex:4}
	enum taste: {shoyu: 0,miso: 1,shio: 2,tokumiso: 3,karamiso: 4,premium_salt:5,other_taste:6}
	enum ingredients: {normal:0,negi:1,chashu:2,negichashu:3,pirikara:4,tsukemen:5,other_ingredients:6}

end
