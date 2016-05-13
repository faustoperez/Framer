# Set device background 
Framer.Device.background.backgroundColor = "#FF96A8"

# Import file "multiply" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/multiply@2x")

# Colors
colors = ["#FFDB09", "#06AFE0", "#76C75E", "#F95B26", "#FF96A8",]

ball = new Layer
	height: 425
	width: 425
	borderRadius: "50%"
	backgroundColor: colors[0]
	x: Align.center
	y: 0
	style:
		"mix-blend-mode": "multiply"

ballA = ball.copy()
ballA.style = "mix-blend-mode": "multiply"
ballA.backgroundColor = colors[1]

ballB = ball.copy()
ballB.style = "mix-blend-mode": "multiply"
ballB.backgroundColor = colors[2]

ballC = ball.copy()
ballC.style = "mix-blend-mode": "multiply"
ballC.backgroundColor = colors[3]

ballD = ball.copy()
ballD.style = "mix-blend-mode": "multiply"
ballD.backgroundColor = colors[4]

ball.draggable.enabled = true
ball.draggable.horizontal = false
ball.draggable.constraints =
	x: 0
	y: 0
	width: Screen.width
	height: Screen.height
	

ball.on "change:y", ->
	ballA.y = Utils.modulate @y, [0, Screen.height], [0, Screen.height * .25]
	ballB.y = Utils.modulate @y, [0, Screen.height], [0, Screen.height * .5]
	ballC.y = Utils.modulate @y, [0, Screen.height], [0, Screen.height * .75]
