class AllergenLabelling < ActiveRecord::Base
	belongs_to :menu
	belongs_to :allergen
	enum label: {
		not_used: 0,
		ingredient_derived: 1,
		used_in_product_line: 2
	}
end
