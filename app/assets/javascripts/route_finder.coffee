$ ->
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
          p = $.param(gmap_params)
          location.href = "https://maps.google.com/maps?#{p}"
