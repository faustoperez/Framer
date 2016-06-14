# Set device background 
Framer.Device.background.backgroundColor = "rgba(42,147,208,1)"

# Import file "parallax" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/parallax@2x")

# Variables
bg = sketch.bg
yPos = []
layers = []

for layer in sketch.content.subLayers
	if layer isnt bg
		layer.y -= 400
		layer.x -= 28
		layer.superLayer = Framer.Device.Screen
		yPos.push(layer.y)
		layers.push(layer)

scroll = new ScrollComponent
	wrap: sketch.content

# Change scroll.content properties 
scroll.content.draggable.momentum = false
scroll.content.draggable.overdrag = false

# Interaction
scroll.onScroll (event) ->
	for layer, i in layers
		if layer.name is "sun"
			layer.y = (Utils.modulate @y, [0, bg.y], [0, Screen.height * -0.4]) + yPos[i]
		else
			layer.y = (Utils.modulate @y, [0, bg.y], [0, Screen.height * i/10]) + yPos[i]
			
