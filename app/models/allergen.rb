class Allergen < ActiveRecord::Base
	has_one :allergen_labellings
	enum division: {prescribed: 0,recommend: 1}
end
