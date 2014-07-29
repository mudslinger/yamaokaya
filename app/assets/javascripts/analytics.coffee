do(i = window,s = document,o = 'script',g = '//www.google-analytics.com/analytics.js',r = 'ga') ->
	i['GoogleAnalyticsObject']=r
	i[r]=i[r] || ->
		(i[r].q=i[r].q||[]).push(arguments)
	i[r].l=1*new Date()
	a=s.createElement(o)
	m=s.getElementsByTagName(o)[0]
	a.async=1
	a.src=g
	m.parentNode.insertBefore(a,m)
codes = 
	'www.yamaokaya.com': 'UA-3359034-1'
	'maruchiyo.yamaokaya.com': 'UA-3359034-2'
	'recruit.yamaokaya.com': 'UA-3359034-3'
	'www2014.yamaokaya.com': 'UA-3359034-1'
	'maruchiyo2014.yamaokaya.com': 'UA-3359034-2'
	'recruit2014.yamaokaya.com': 'UA-3359034-3'
code = codes[location.hostname]

if code?
	ga('create', code, 'auto')
	ga('send', 'pageview');
