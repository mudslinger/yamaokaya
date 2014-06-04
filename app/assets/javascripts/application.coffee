#= require jquery
#= require jquery_ujs

#= require bootstrap
#= require bootstrap-select
#= require flot/excanvas
#= require flot/jquery.flot
#= require flot/jquery.flot.resize

#価格の書き換え
#= require digits
#google maps 読み込み
#= require maps

#truncate text

#topナビゲーション 透明化
#= require top_header

#Notification slide
#= require noty

#=require smooth

#=require chart

$('p.truncate').each (i,o)->
	$(o).text($(o).text().substr(0,60) + '...')

rf = (ticker,news,i)->
	ticker.css(left: '1800px',opacity: 1)
	ticker.html(news.get(i))
	ticker.animate left:0,800
	ret = (if i+1 >= news.length then 0 else i+1)

if $('body.top').get(0)?
	ticker = $('#ticker')
	news = $('a.original-news').clone(false)
	idx = rf(ticker,news,0)
	setInterval -> 
		idx = rf(ticker,news,idx)
	,10000

#ヒストリーのグラフ
$ ->
	if $('body.corporate.company').get(0)?
		$('div.progress-bar').each (idx,o)->
			shops = o.getAttribute('aria-valuenow')
			max = 140
			console.log shops / max
			$(o).css(width:"#{shops/max*100}%")

#リクルートのエントリーフォーム
$ ->
	if $('body.recruit.entries').get(0)?
		$('.selectpicker').selectpicker()