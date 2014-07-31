# if (%x[whoami]).chomp == 'root'
# 	DOMAINS = {
# 		corporate: 'yam.jp',
# 		yamaokaya: 'yam.com',
# 		recruit:   'recruit.yam.com'
# 	}
# else
# 	DOMAINS = {
# 		corporate: 'maruchiyo2014.yamaokaya.com',
# 		yamaokaya: 'www2014.yamaokaya.com',
# 		recruit:   'recruit2014.yamaokaya.com'
# 	}
# end

DOMAINZ = {
	'maruchiyo2014.yamaokaya.com' => :corporate,
	'www2014.yamaokaya.com' => :yamaokaya,
	'recruit2014.yamaokaya.com' => :recruit,
	'maruchiyo.yamaokaya.com' => :corporate,
	'www.yamaokaya.com' => :yamaokaya,
	'yamaokaya.com' => :yamaokaya,
	'recruit.yamaokaya.com' => :recruit,
	'yam.jp' => :corporate,
	'yam.com' => :yamaokaya,
	'recruit.yam.com' => :recruit
}

CORPORATE_DOMAINZ = DOMAINZ.select do |k,v|
	v == :corporate
end

YAMAOKAYA_DOMAINZ = DOMAINZ.select do |k,v|
	v == :yamaokaya
end

RECRUIT_DOMAINZ = DOMAINZ.select do |k,v|
	v == :recruit
end

CORP_DEF = (%x[whoami]).chomp == 'root' ? 'yam.jp' : 'maruchiyo.yamaokaya.com'
YAM_DEF = (%x[whoami]).chomp == 'root' ? 'yam.com' : 'www.yamaokaya.com'
REC_DEF = (%x[whoami]).chomp == 'root' ? 'recruit.yam.com' : 'recruit.yamaokaya.com'
