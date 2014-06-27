$ ->
	rf = (ticker,news,i)->
		ticker.css(left: '1800px',opacity: 1)
		ticker.html(news.get(i))
		ticker.animate left:0,800
		ret = (if i+1 >= news.length then 0 else i+1)

	if $('body.top').get(0)?
		ticker = $('#ticker')
		#iconを追加
		news = $('a.original-news').clone(false)
		# news.each =>
		# 	$("<span class='glyphicon glyphicon-bullhorn' />").prependTo($(@))

		idx = rf(ticker,news,0)
		setInterval -> 
			idx = rf(ticker,news,idx)
		,10000