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

ga('create', 'UA-3359034-1', 'auto')
ga('send', 'pageview')