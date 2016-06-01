# Set device background 
Framer.Device.background.backgroundColor = "rgba(42,147,208,1)"


# Import file "parallax" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/parallax@2x")

# Position layers and save the y position in an array 

yPos = []

for layer in sketch.content.subLayers
	if layer isnt sketch.bg
		layer.superLayer = Framer.d
		layer.centerX()
		layer.y -= 400
		yPos.push(layer.y)

# Wrap the "content" layer group 
scroll = ScrollComponent.wrap(sketch.content)
 
# Change scroll properties 
scroll.scrollHorizontal = false
scroll.speedY = 2
 
# Change scroll.content properties 
scroll.content.draggable.momentum = true
scroll.content.draggable.overdrag = false
scroll.content.draggable.bounce = false


scroll.onScroll ->
	sketch.sun.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .01]) - 400
	sketch.clouds3.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .05]) + 316
	sketch.clouds2.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .07]) + 424
	sketch.clouds1.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .08]) + 524
	sketch.mountains3.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .05]) + 522
	sketch.mountains2.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .06]) + 642
	sketch.mountains1.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .07]) + 762
	sketch.trees4.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .08]) + 874
	sketch.trees3.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .09]) + 994
	sketch.trees2.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .1]) + 1114
	sketch.trees1.y = (Utils.modulate @y, [0, sketch.bg.y], [0, Screen.height * .11]) + 1234

    	


	

