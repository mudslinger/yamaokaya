if $('#location').get(0) && $('#zoom').get(0)
	idokeido = $('#location').text()
	zoom = $('#zoom').text()
	lat = idokeido.split(',')[0] if idokeido?
	lng = idokeido.split(',')[1] if idokeido?
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
	)
if $('#indexmap').get(0)
	mapOptions = {
		zoom: 4
		center: new google.maps.LatLng(39,137)
		mapTypeId: google.maps.MapTypeId.ROADMAP
		scaleControl: true
	}
	mapObj = new google.maps.Map(document.getElementById('indexmap'), mapOptions)
	douou_ll = [
		[43.057967,141.35621],
		[43.129596,141.210969],
		[42.961548,141.274245],
		[43.131467,141.347034],
		[43.09158937,141.4185073],
		[42.874185,141.58404],
		[42.97346375,141.56775],
		[43.211573,141.783987],
		[43.104051,141.378059],
		[43.143939,141.27656],
		[43.09410768,141.5255146],
		[43.54109868,141.9229711],
		[43.05360397,141.353169],
		[42.82102422,141.6569727],
		[43.01856597,141.40778],
		[43.028084,141.448481],
		[43.057028,141.351696],
		[43.1747,141.060097]
	]
	doutou_ll = [
		[43.01435229,144.3193365]
		[43.79809339,143.8643184]
		[42.93148202,143.1931838]
		[43.81894599,144.116233]
		[42.882326,143.200698]
		[43.013426,144.403739]
		[43.999815,144.284241]
	]
	douou = for ll in douou_ll
		new google.maps.Marker
			position: new google.maps.LatLng ll[0],ll[1]
			map: mapObj
	doutou = for ll in doutou_ll
		new google.maps.Marker
			position: new google.maps.LatLng ll[0],ll[1]
			map: mapObj
	markerClustererOptions =
		description: '道央',  
		maxZoom: 12,  
		gridSize: 50  

	cluster_douou = new MarkerClusterer mapObj,douou,markerClustererOptions
	cluster_doutou = new MarkerClusterer mapObj,doutou,markerClustererOptions


	

