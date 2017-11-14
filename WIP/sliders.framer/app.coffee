bg = new BackgroundLayer
	backgroundColor: "rgba(94,94,94,1)"

width = Screen.width / 10
gutter = 60

# Define & Position sliders
timeSlider = new SliderComponent 
	x: Align.center(), height: 6
	
amountSlider = new SliderComponent 
	x: Align.center(- width - gutter), height: 6

sizeSlider = new SliderComponent 
	x: Align.center(+ width + gutter), height: 6
	
# Store them in an array to add default properties 
allSliders = [timeSlider, amountSlider, sizeSlider]

for slider in allSliders	
	
	# Position
	
	slider.y = 50
	slider.width = width
	
	# Style
	slider.knobSize = 30
	slider.knob.scale = 0.8
	slider.knob.borderRadius = 30
	slider.backgroundColor = "rgba(255,255,255,0.1)"
	slider.fill.backgroundColor = "rgba(255,255,255,1)"
	
	# Default min - max values
	slider.min = 50
	slider.max = 150
	slider.value = 100
	
	slider.knob.on Events.DragStart, ->
		@animate 
			properties: {scale: 1}
			curve: "spring(400,30,0)"
			
	slider.knob.on Events.DragEnd, ->
		@animate 
			properties: {scale: 0.8}
			curve: "spring(400,30,0)"
#
# 
# # Set-up
# 
# contrastSlider.on "change:value", -> sketch.photo.contrast = this.value
# brightnessSlider.on "change:value", -> sketch.photo.brightness = this.value
# saturateSlider.on "change:value", -> sketch.photo.saturate = this.value