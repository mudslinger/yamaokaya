DOMAINZ = {
	'maruchiyo2014.yamaokaya.com' => :corporate,
	'www2014.yamaokaya.com' => :yamaokaya,
	'yamapps4wide-1355007300.ap-northeast-1.elb.amazonaws.com' => :yamaokaya,
	'recruit2014.yamaokaya.com' => :recruit,
	'maruchiyo.yamaokaya.com' => :corporate,
	'www.yamaokaya.com' => :yamaokaya,
	'yamaokaya.com' => :yamaokaya,
	'recruit.yamaokaya.com' => :recruit,
	'yam.jp' => :corporate,
	'yam.com' => :yamaokaya,
	'localhost' => :corporate,
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
