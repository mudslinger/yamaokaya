# $('#accordion').collapse toggle: false
$ ->
	draw = (btn,box,id)->
		if box.css('left') == '-282px'
			box.animate left:0,300
			btn.animate left:280,300
			$('.noty-content .panel-collapse').each ->
				console.log $(@).attr('id')
				if $(@).attr('id') == id && !$(@).hasClass('in')
					$(@).collapse('toggle')
				if $(@).hasClass('in')
					$(@).collapse('toggle')

		else
			box.animate left:-282,300
			btn.animate left:280,300

	$('.original-news').click ->
		draw $(@).parent(),$(@).parent().parent(),'collapse-01'
	$('.facebook').click ->
		draw $(@).parent(),$(@).parent().parent(),'collapse-02'
	$('.twitter').click ->
		draw $(@).parent(),$(@).parent().parent(),'collapse-03'
