#= require jquery
#= require jquery_ujs

#= require bootstrap
#= require bootstrap-select
#= require flot/excanvas
#= require flot/jquery.flot
#= require flot/jquery.flot.resize
#= require gmaps
#= require progressbar

#価格の書き換え
#= require digits
#google maps 読み込み
#= require maps

#topナビゲーション 透明化
#= require top_header

#Notification slide
#= require noty

#トップ画面 ticker
#=require ticker

#トップ画面　スムーススクロール
#=require smooth

#コーポレート　チャート系
#=require chart

#コーポレートトップの短縮
$ ->
	$('p.truncate').each (i,o)->
		$(o).text($(o).text().substr(0,60) + '...')


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
