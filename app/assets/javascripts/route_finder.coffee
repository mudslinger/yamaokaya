$ ->
  gogmap = (q)->
    params = $.param(q)
    location.href = "https://maps.google.com/maps?#{params}"

  if $('#find_route').get(0)
    if (navigator.geolocation)
      $('#find_route').on 'click', ->
        gmap_params =
          ie: 'UTF8'
          oe: 'UTF8'
          f: 'd'
          dirflg: 'd'
          daddr: $('#lat').text() + ',' + $('#lng').text()
          ttype: 'now'
          t: 'm'
        navigator.geolocation.getCurrentPosition (pos)=>
          gmap_params.saddr = "#{pos.coords.latitude},#{pos.coords.longitude}"
          gogmap(gmap_params)
  if $('#show_shop').get(0)
    $('#show_shop').on 'click', ->
      gmap_params =
        ie: 'UTF8'
        oe: 'UTF8'
        q: $('#lat').text() + ',' + $('#lng').text()
      gogmap(gmap_params)

