#= require jquery
#= require jquery_ujs

#= require bootstrap
#= require bootstrap-select
#= require analytics
#= require sns
#= require flot/excanvas
#= require flot/jquery.flot
#= require flot/jquery.flot.resize

#bxslider
#= require bxslider/jquery.bxslider

#価格の書き換え
#= require digits
#google maps 読み込み
#= require maps

#topナビゲーション 透明化
#= require top_header

#Notification slide
#= require noty

#トップ画面 店舗 feeling lucky
#=require shop_feel_lucky

#トップ画面 ticker
#=require ticker

#トップ画面　スムーススクロール
#=require smooth

#コーポレート　チャート系
#=require chart

#道案内表示
#=require route_finder

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
			$(o).css(width:"#{shops/max*100}%")

#リクルートのエントリーフォーム
$ ->
	if $('body.recruit.entries').get(0)?
		$('.selectpicker').selectpicker()

#モバイル用SELECT
$ ->
	if $('#mobile-pref-selector').get(0)?
		$('#mobile-pref-selector').change ->
			location.href = $(@).val()

#店舗ページ用bxslider
$ ->
	if $('body.shops').get(0)?
		$('.bxslider').bxSlider
			pagerCustom: '#bx-pager'
