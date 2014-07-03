$ ->
	class ShopMarker extends google.maps.Marker
		constructor: (@local_id,@name,@map,@lat,@lng,x=0,y=0)->
			super(
				position: new google.maps.LatLng(@lat,@lng)
				map: @map
				title: @name
				visible: false
				icon: new google.maps.MarkerImage(
					"//assets.yamaokaya.com/images/shops/flags/shops.png"
					 new google.maps.Size(24, 56)
					 new google.maps.Point(x, y)
				)
			)
			google.maps.event.addListener(@map,'zoom_changed',=>
				zoom = map.getZoom()
				@setVisible zoom >= 10
			)

	class AbstractMarker extends  google.maps.Marker
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
			@map.fitBounds @getBounds()

	class AreaMarker extends AbstractMarker
		constructor: (@local_id,@name,@map,@lat,@lng,@swne)->
			super(
				position: @getPosition()
				map: @map
				title: @name
				visible: false
			)
			google.maps.event.addListener(@map,'zoom_changed',=>
				zoom = map.getZoom()
				@setVisible zoom >= 9 && zoom < 10
			)
			google.maps.event.addListener(@,'click',=> @breakdown())

	class PrefMarker extends AbstractMarker
		constructor: (@local_id,@name,@map,@lat,@lng,@swne,x=0,y=0)->
			super(
				position: @getPosition()
				map: @map
				title: @name
				visible: false
				icon: new google.maps.MarkerImage(
					"//assets.yamaokaya.com/images/shops/flags/prefectures.png"
					 new google.maps.Size(24, 56)
					 new google.maps.Point(x, y)
				)
			)
			google.maps.event.addListener(@map,'zoom_changed',=>
				zoom = map.getZoom()
				@setVisible zoom >= 7 && zoom < 9
			)
			google.maps.event.addListener(@,'click',=> @breakdown())

	class RegionMarker extends AbstractMarker
		constructor: (@local_id,@name,@map,@lat,@lng,@swne,x=0,y=0)->
			super(
				position: @getPosition()
				map: @map
				title: @name
				icon: new google.maps.MarkerImage(
					"//assets.yamaokaya.com/images/shops/flags/regions.png"
					 new google.maps.Size(24, 56)
					 new google.maps.Point(x, y)
				)
			)
			google.maps.event.addListener(@map,'zoom_changed',=>
				zoom = map.getZoom()
				@setVisible zoom < 7
			)
			google.maps.event.addListener(@,'click',=> @breakdown())
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

		shops = {
			<% @regions.each do |r| %>
			<% r.shops.each do |s| %>
			<%=s.id%>: new ShopMarker(
				<%=s.id%>
				'<%=s.name%>'
				map
				<%=s.lat%>
				<%=s.lng%>
				<%=s.sprite_x%>
				<%=s.sprite_y%>	
			)
			<% end %>
			<% end %>
		}
		areas = {
			<% @regions.each do |r| %>
			<% r.areas.each do |a| %>
			<%=a.id%>: new AreaMarker(
				<%=a.id%>,
				'<%=a.name%>'
				map
				<%=a.lat%>
				<%=a.lng%>	
				{
					s: <%=a.bounds[:s]%>,
					w: <%=a.bounds[:w]%>,
					n: <%=a.bounds[:n]%>,
					e: <%=a.bounds[:e]%>
				}
			)
			<% end %>
			<% end %>
		}
		prefs = {
			<% @regions.each do |r| %>
			<% r.prefectures.each do |p| %>
			<%=p.id%>: new PrefMarker(
				<%=p.id%>
				'<%=p.name%>'
				map
				<%=p.lat%>
				<%=p.lng%>	
				{
					s: <%=p.bounds[:s]%>,
					w: <%=p.bounds[:w]%>,
					n: <%=p.bounds[:n]%>,
					e: <%=p.bounds[:e]%>
				}
				<%=p.sprite_x%>
				<%=p.sprite_y%>
			)
			<% end %>
			<% end %>
		}
		regions = {
			<%@regions.each do |r| %>
			<%if r.has_shops? %>
			<%=r.id%>: new RegionMarker(
				<%=r.id%>
				'<%=r.name%>'
				map
				<%=r.lat%>
				<%=r.lng%>				
				{
					s: <%=r.bounds[:s]%>,
					w: <%=r.bounds[:w]%>,
					n: <%=r.bounds[:n]%>,
					e: <%=r.bounds[:e]%>
				}
				<%=r.sprite_x%>
				<%=r.sprite_y%>
			)
			<% end %>
			<% end %>
		}

		# region_opts = { gridSize: 50, maxZoom: 5}
		# pref_opts = { gridSize: 50, maxZoom: 8}
		# regions_x = {
		# 	<%Region.all.each do |r| %>
		# 	<%=r.id%>: new MarkerClusterer(
		# 		map,
		# 		[
		# 			<% r.prefectures.each do |p| %>
		# 			<% p.shops.each do |ps| %>
		# 			markers[<%=ps.id%>]
		# 			<% end %>
		# 			<% end %>
		# 		],
		# 		region_opts
		# 	)
		# 	<% end %>
		# }
		# prefectures_x = {
		# 	<%Prefecture.all.each do |p| %>
		# 	<%unless p.shops.size == 0%>
		# 	<%=p.id%>: new MarkerClusterer(
		# 		map,
		# 		[
		# 			<% p.shops.each do |ps| %>
		# 			markers[<%=ps.id%>]
		# 			<% end %>
		# 		],
		# 		pref_opts
		# 	)
		# 	<% end %>
		# 	<% end %>
		# }
