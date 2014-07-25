$("#modal").html "<%=escape_javascript(render partial: 'yamaokaya_menu_details_modal')%>"
$('#myModal').modal()
imgs = 
	'0':'//assets0.yamaokaya.com/i/origin/images/menus/digits/0.png'
	'1':'//assets1.yamaokaya.com/i/origin/images/menus/digits/1.png'
	'2':'//assets2.yamaokaya.com/i/origin/images/menus/digits/2.png'
	'3':'//assets3.yamaokaya.com/i/origin/images/menus/digits/3.png'
	'4':'//assets4.yamaokaya.com/i/origin/images/menus/digits/4.png'
	'5':'//assets5.yamaokaya.com/i/origin/images/menus/digits/5.png'
	'6':'//assets6.yamaokaya.com/i/origin/images/menus/digits/6.png'
	'7':'//assets7.yamaokaya.com/i/origin/images/menus/digits/7.png'
	'8':'//assets0.yamaokaya.com/i/origin/images/menus/digits/8.png'
	'9':'//assets1.yamaokaya.com/i/origin/images/menus/digits/9.png'
repdigit = (element)->
	return unless element
	element.each ->
		price = $(@).text()
		pchars = price.split('')
		$(@).empty()
		for i in pchars
			$(@).append $("<img class='digit' src='#{imgs[i]}' alt='#{i}' />")

repdigit $('.repdigit') if $('.repdigit').get(0)?