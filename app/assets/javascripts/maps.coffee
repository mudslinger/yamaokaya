$ ->
	if $('#lat').get(0) && $('#lng').get(0) && $('#zoom').get(0)
		zoom = parseInt $('#zoom').text()
		lat =  parseFloat $('#lat').text()
		lng =  parseFloat $('#lng').text()
		x = parseInt $('#sprite_x').text()
		y = parseInt $('#sprite_y').text()
		latlng = new google.maps.LatLng(lat, lng)
		mapOptions = {
			zoom: parseInt(zoom)
			center: latlng
			mapTypeId: google.maps.MapTypeId.ROADMAP
			scaleControl: true
		}
		mapObj = new google.maps.Map(document.getElementById('maps'), mapOptions)
		marker = new google.maps.Marker(
			position: latlng
			map: mapObj
			icon: new google.maps.MarkerImage(
				'http://assets.yamaokaya.com/images/shops/flags/shops.png',
				 new google.maps.Size(24, 56)
				 new google.maps.Point(x, y)
			)
		)

#地図クラス
$ ->

	window.requestAnimFrame = ->
		func = (callback)->
			window.setTimeout(callback, 1000 / 60)
		return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame    || window.oRequestAnimationFrame || window.msRequestAnimationFrame || func 
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
			@start_shows = json.start_shows
			@end_shows = json.end_shows
			super(
				position: @getPosition()
				map: @map
				title: @name
				icon: @getIcon()
			)
			@changeVisible(map.getZoom())
			google.maps.event.addListener(@,'click',=> @breakdown())
			
		# getChildrenAjax: (callback)->
		# 	opts = {key: @local_id,type: @markerType()}
		# 	$.getJSON "/children.json",opts, callback
		changeVisible: (zoom)->
			@setVisible(@start_shows <= zoom <= @end_shows)

	class RegionMarker extends AbstractMarker
		markerType: -> 'region'
		getIcon: ->
			new google.maps.MarkerImage(
				"http://assets.yamaokaya.com/images/shops/flags/regions.png"
				 new google.maps.Size(24, 56)
				 new google.maps.Point(@sprite_x, @sprite_y)
			)

	class PrefectureMarker extends AbstractMarker
		markerType: -> 'prefecture'
		getIcon: ->
			new google.maps.MarkerImage(
				"http://assets.yamaokaya.com/images/shops/flags/prefectures.png"
				 new google.maps.Size(24, 56)
				 new google.maps.Point(@sprite_x, @sprite_y)
			)

	class AreaMarker extends AbstractMarker
		markerType: -> 'area'
		getIcon: ->
			new google.maps.MarkerImage(
				"http://assets.yamaokaya.com/images/shops/flags/areas.png"
				 new google.maps.Size(24, 56)
				 new google.maps.Point(@sprite_x, @sprite_y)
			)

	class ShopMarker extends AbstractMarker
		markerType: -> 'shop'
		getIcon: ->
			new google.maps.MarkerImage(
				"http://assets.yamaokaya.com/images/shops/flags/shops.png"
				 new google.maps.Size(24, 56)
				 new google.maps.Point(@sprite_x, @sprite_y)
			)
		breakdown: ->
			location.href = "/shops/#{@local_id}.html"

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
			pb.start(100)
			$.getJSON "/markers.json",{zoom: zoom}, (json)->
				animate(json,0)
				loaded[zoom] = true
				console.log loaded
	animationFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame	|| window.mozRequestAnimationFrame || window.setTimeout
	animate = (json,idx)->		
		console.log idx
		createMarker json[idx],map
		pb.updateBar 100 / json.length-1
		if json.length-1 > idx
			window.requestAnimFrame(animate(json,idx+1))
		else
			pb.hide()


	if $('#index-map').get(0)
		map = new google.maps.Map(
			$('#index-map').get(0)
			{
				zoom:5
				center: new google.maps.LatLng(39.7868944,137.7877029)
				mapTypeId: google.maps.MapTypeId.ROADMAP,
				noClear : true
			}
		)
		pb = progressBar()
		map.controls[google.maps.ControlPosition.RIGHT].push(pb.getDiv())

		loadMarkers map
		google.maps.event.addListener map,'zoom_changed',->
			loadMarkers map
			for k,v of markers
				v.changeVisible(map.getZoom())
	

