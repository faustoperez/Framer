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
	textShadow: "#852F26 .01em .01em 0,
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



