$ ->
	do (d = document,s = 'script',id = 'facebook-jssdk')->
		fjs = d.getElementsByTagName(s)[0]
		unless d.getElementById(id)
			js = d.createElement(s)
			js.id = id
			js.src = "//connect.facebook.net/ja_JP/sdk.js#xfbml=1&appId=413348325454935&version=v2.0"
			fjs.parentNode.insertBefore(js, fjs)

	!do(d=document,s='script',id='twitter-wjs')->
		fjs=d.getElementsByTagName(s)[0]
		p= if /^http:/.test(d.location) then 'http' else 'https'
		if !d.getElementById(id)
			js=d.createElement(s);
			js.id=id;
			js.src=p+"://platform.twitter.com/widgets.js";
			fjs.parentNode.insertBefore(js,fjs)