$ ->
  if $('#search_shop').get(0)
    if (navigator.geolocation)
      $('#search_shop').on 'click', ->
        navigator.geolocation.getCurrentPosition (pos)=>
          ll = 
            lat: pos.coords.latitude
            lng: pos.coords.longitude
          $.get $(@).data('href'),ll, (data)->
            #eval(data)
          $('#user-latlng').text "#{pos.coords.latitude},#{pos.coords.longitude}"
        ,(err)->
          alert '申し訳ありません。現在位置の取得に失敗しました。'

        false

      $('#search_shop').css('display','inline')
    else
      $('#search_shop').css('display','hidden')