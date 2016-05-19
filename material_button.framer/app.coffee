bg = new BackgroundLayer
	backgroundColor: "#f5f5f5"

# Create the button
button = new Layer
	width: 350
	height: 100
	backgroundColor: "#2196F3"
	borderRadius: 5
	shadowY: 1
	shadowBlur: 2
	shadowSpread: 1
	shadowColor: "rgba(0,0,0,.25)"
button.center()
button.clip = true

# Create the ripple layer
ripple = new Layer
	superLayer: button
	width: 100
	height: 100
	opacity: 0
	backgroundColor: "rgba(255,255,255,.5)"
	borderRadius: "50%"


# Create the text layer
text = new Layer
	superLayer: button
	backgroundColor: "transparent"
	html: "button"
	style:
		display: "flex"
		justifyContent: "center"
		color: "#fff"
		alignItems: "center"
		fontSize: "24px"
		fontFamily: "Roboto"
		letterSpacing: "1px"
		textTransform: "uppercase"
	
text.center()
	
# Click event
button.on Events.Click, (event) ->
	ripple.midX = event.offsetX
	ripple.midY = event.offsetY
	ripple.scale = 0
	ripple.opacity = 1
	ripple.container = button
	ripple.animate
		properties:
			scale: 6
			opacity: 0
		curve: "ease-out"
		time: .5
	
	button.animate
		properties:
			shadowY: 5
			shadowBlur: 5
		time: .3
	Utils.delay .3, ->
		button.animate
			properties:
				shadowY: 1
				shadowBlur: 2
			time: .3
	
	text.animate
		properties:
			scale: 1.01
		time: .3
	Utils.delay .3, ->
		text.animate
			properties:
				scale: 1
			time: .3
