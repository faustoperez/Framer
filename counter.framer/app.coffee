{Firebase} = require 'firebase'

bg = new BackgroundLayer
	backgroundColor: "rgba(98,220,255,1)"

Utils.insertCSS('@import url(https://fonts.googleapis.com/css?family=Bungee);')

counter = new Layer
	backgroundColor: "transparent"
	width: Screen.width

counter.html = "0123456789"
counter.style = {
	fontFamily: "Bungee"
	textAlign: "center"
	fontSize: "5em"
	textShadow: "#852F26 .01em .01em 0, 				#852F26 .02em .02em 0, 				#852F26 .03em .03em 0, 				#852F26 .04em .04em 0, 				#852F26 .05em .05em 0, 				#852F26 .06em .06em 0, 				#852F26 .07em .07em 0, 				#852F26 .08em .08em 0, 				#852F26 .09em .09em 0, 				#852F26 .1em .1em 0,
 				#852F26 .11em .11em 0,
 				#852F26 .12em .12em 0,
 				#852F26 .13em .13em 0,
 				#852F26 .14em .14em 0,
 				#852F26 .15em .15em 0"
}

counter.center()

firebase = new Firebase
    projectID: "framer-counter"
    secret: "h55y3eq6Lqs3iIHrF9XXR9qoQLWnWxAGEgjXtvpd"
    server: "s-usc1c-nss-128.firebaseio.com"




