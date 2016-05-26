# Import file "animals" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/animals@2x")

# Set device background 
Framer.Device.background.backgroundColor = "#0098B3"

bg = new BackgroundLayer
	backgroundColor: "rgba(240,240,255,1)"
	
Framer.Defaults.Animation =
   curve: "spring(200,20,0)"

# Set initial states for layers
	
for layer in sketch.animals.subLayers
	layer.style = "mix-blend-mode": "multiply"

sketch.vulture.visible = true
sketch.vulture.opacity = 0
sketch.vulture.y = Screen.height

# States

sketch.big_triangle1.states.add
	vulture:
		x: 709
		y: 846
		rotation: 90

sketch.big_triangle2.states.add
	vulture:
		x: 830
		y: 560
		rotation: -45

sketch.square.states.add
	vulture:
		x: 1330
		y: 440

sketch.md_triangle.states.add
	vulture:
		y: 1000
		x: 328
		rotation: 135

sketch.parallelogram.states.add
	vulture:
		y: 1280
		x: 114
		rotation: 135

sketch.sm_triangle1.states.add
	vulture:
		y: 1463
		x: 572
		rotation: 225

sketch.sm_triangle2.states.add
	vulture:
		y: 544
		x: 1630
		rotation: 90

sketch.kangaroo.states.add
	vulture:
		opacity: 0
		y: Screen.height

sketch.vulture.states.add
	vulture:
		opacity: 1
		y: 2085
		
 # Events

sketch.animals.on Events.Click, ->
	for layer in sketch.animals.subLayers
		layer.states.next()
