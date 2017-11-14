#background
bg = new BackgroundLayer
	width: Screen.width
	height: Screen.height
	backgroundColor: "#F0F7EF"
	
# SLIDERS

# width = Screen.width - 240
# 
# # Define & Position sliders
# contrastSlider = new SliderComponent 
# 	x: 196, y: 980, width: width, height: 6
# 	
# brightnessSlider = new SliderComponent 
# 	x: 196, y: 1100, width: width, height: 6
# 
# saturateSlider = new SliderComponent 
# 	x: 196, y: 1220, width: width, height: 6
# 	
# # Store them in an array to add default properties 
# allSliders = [contrastSlider, brightnessSlider, saturateSlider]
# 
# for slider in allSliders	
# 	
# 	# Style
# 	slider.knobSize = 45
# 	slider.knob.scale = 0.8
# 	slider.knob.borderRadius = 30
# 	slider.backgroundColor = "rgba(255,255,255,0.1)"
# 	slider.fill.backgroundColor = "rgba(255,255,255,1)"
# 	
# 	# Default min - max values
# 	slider.min = 50
# 	slider.max = 150
# 	slider.value = 100
# 	
# 	slider.knob.on Events.DragStart, ->
# 		this.animate 
# 			properties: {scale: 1}
# 			curve: "spring(400,30,0)"
# 			
# 	slider.knob.on Events.DragEnd, ->
# 		this.animate 
# 			properties: {scale: 0.8}
# 			curve: "spring(400,30,0)"
# 
# saturateSlider.min = 0
# saturateSlider.max = 200
# saturateSlider.value = 100
# 
# # Set-up
# sketch.photo.contrast = contrastSlider.value
# sketch.photo.brightness = brightnessSlider.value
# sketch.photo.saturate = saturateSlider.value
# 
# contrastSlider.on "change:value", -> sketch.photo.contrast = this.value
# brightnessSlider.on "change:value", -> sketch.photo.brightness = this.value
# saturateSlider.on "change:value", -> sketch.photo.saturate = this.value


# variables
colors = ["#55B247", "#F27589", "#FDC938", "#EF473F", "#75CEDE", "#0089A5"]

amount = 200
time = 2

shapes = ['<svg width="96" height="91" viewBox="0 0 96 91"><polygon id="star" fill="#CCC" fill-rule="evenodd" points="48 75 18.611 90.451 24.224 57.725 .447 34.549 33.305 29.775 48 0 62.695 29.775 95.553 34.549 71.776 57.725 77.389 90.451"/></svg>']

	#loop
for i in [0...amount]

	color = colors[Math.floor(Utils.randomNumber(0, colors.length))]
	
	#creating the particles
	particle = new Layer
		html: shapes[Math.floor(Utils.randomNumber(0, shapes.length))]
		backgroundColor: ""
		scale: Utils.randomNumber(0.5, 1.5)
		x: Utils.randomNumber() * Screen.width
		y: (Utils.randomNumber() * (Screen.height - 100)) + 100
		style:
			"mix-blend-mode": "multiply"
			
# 	# select path and add CSS transition
	fill = particle.querySelector('#star')
	fill.setAttribute("fill", "#{color}")

# 	creating the animation
	forwardAnimation = new Animation
		layer: particle
		properties:
			x: Utils.randomNumber() * Screen.width
			y: (Utils.randomNumber() * (Screen.height - 100)) + 100
		options:
			time: time
	
	reverseAnimation = forwardAnimation.reverse()

	# Alternate between the two animations 
	forwardAnimation.on Events.AnimationEnd, reverseAnimation.start
	reverseAnimation.on Events.AnimationEnd, forwardAnimation.start
	 
	forwardAnimation.start()
