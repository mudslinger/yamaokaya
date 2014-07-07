#地図クラス
$ ->
	markers = {}
	loaded = {}
	class AbstractMarker extends google.maps.Marker
		getPosition: ->
			@position = new google.maps.LatLng(@lat,@lng) unless @position?
			@position

		getBounds: ->
			@bounds = new google.maps.LatLngBounds(
				new google.maps.LatLng(@swne.s,@swne.w)
				new google.maps.LatLng(@swne.n,@swne.e)
			) unless @bounds?
			@bounds

		breakdown: ->
			# unless @bounds?
			# 	callback = (json)=>
			# 		console.log json
			# 		@children = (createMarker(o,@map) for o in json)
			# 		# @bounds = new google.maps.LatLngBounds()
			# 		# for obj in @children
			# 		# 	@bounds.extend obj.getPosition()
			# 		@map.fitBounds @getBounds()
			# 	@getChildrenAjax callback
			# else
			@map.setZoom(@end_shows+1)
			@map.setCenter(@getPosition())

		constructor:  (json,@map)->
			@local_id = json.id
			@name = json.name
			@lat = json.lat
			@lng = json.lng
			@sprite_x = json.sprite_x
			@sprite_y = json.sprite_y
			@swne = json.bounds
			@start_shows = json.start_shows || 0
			@end_shows = json.end_shows || 20
			@zoom = json.zoom if json.zoom?
			super(
				position: @getPosition()
				map: @map
				title: @name
				icon: @getIcon()
			)
			@changeVisible(map.getZoom())
			google.maps.event.addListener(@,'click',=> @breakdown())
		changeVisible: (zoom)->
			@setVisible(@start_shows <= zoom <= @end_shows)

	class RegionMarker extends AbstractMarker
		markerType: -> 'region'
		getIcon: ->
			new google.maps.MarkerImage(
				"/i/origin/images/shops/flags/regions.png"
				 new google.maps.Size(53, 32)
				 new google.maps.Point(@sprite_x, @sprite_y)
			)

	class PrefectureMarker extends AbstractMarker
		markerType: -> 'prefecture'
		getIcon: ->
			new google.maps.MarkerImage(
				"/i/origin/images/shops/flags/prefectures.png"
				 new google.maps.Size(21, 53)
				 new google.maps.Point(@sprite_x, @sprite_y)
			)

	class AreaMarker extends AbstractMarker
		markerType: -> 'area'
		getIcon: ->
			new google.maps.MarkerImage(
				"/i/origin/images/shops/flags/areas.png"
				 new google.maps.Size(21, 80)
				 new google.maps.Point(@sprite_x, @sprite_y)
			)

	class ShopMarker extends AbstractMarker
		markerType: -> 'shop'
		getIcon: ->
			new google.maps.MarkerImage(
				"/i/origin/images/shops/flags/shops.png"
				 new google.maps.Size(49, 57)
				 new google.maps.Point(@sprite_x, @sprite_y)
			)
		breakdown: ->
			location.href = "/shops/#{@local_id}.html"
		focus: ->
			@map.setCenter @position
			@map.setZoom @zoom
	class ShopDetailsMarker extends ShopMarker
		breakdown: ->
		focus: ->
			@map.setCenter @position
			@map.setZoom @zoom
		changeVisible: (zoom)->
			@setVisible true

	createMarker = (json,map)->
		#console.log json
		unless markers[json.id]?
			markerType = json.marker_type
			switch markerType
				when 'Region'
					m = new RegionMarker json,map
				when 'Prefecture'
					m = new PrefectureMarker json,map
				when 'Area'
					m = new AreaMarker json,map
				when 'Shop'
					m = new ShopMarker json,map
					console.log m
			markers[m.local_id] = m
	loadMarkers = (map)->
		zoom = map.getZoom()
		unless loaded[zoom]?
			$.getJSON "/markers.json",{zoom: zoom}, (json)->
				for obj in json
					createMarker obj,map


	if $('#index-map').get(0)
		map = new google.maps.Map(
			$('#index-map').get(0)
			{
				zoom:5
				center: new google.maps.LatLng(38.7868944,137.7877029)
				mapTypeId: google.maps.MapTypeId.ROADMAP,
				noClear : true
			}
		)

		loadMarkers map
		google.maps.event.addListener map,'zoom_changed',->
			map.setZoom(4) if map.getZoom() < 4
			loadMarkers map
			for k,v of markers
				v.changeVisible(map.getZoom())

	#現在位置に合わせて地図の表示を変更
	if $('#user-latlng').get(0)
		console.log 'user-latlng'
		$('#user-latlng').bind 'DOMSubtreeModified', ->
			latlng = $('#user-latlng').text().split(',')
			console.log latlng
			map.setCenter new google.maps.LatLng(latlng[0],latlng[1])
			map.setZoom(11	)
	#個別店舗ページ
	if $('#detail-map').get(0) && $('#marker-data').get(0)
		json = $.parseJSON($('#marker-data').text())
		console.log json
		json.start_shows = 0
		json.end_shows = 100
		mapOptions = {
			zoom:5
			center: new google.maps.LatLng(39.7868944,137.7877029)
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			noClear : true
		}
		map = new google.maps.Map($('#detail-map').get(0), mapOptions)
		m = new ShopDetailsMarker json,map
		m.focus()
