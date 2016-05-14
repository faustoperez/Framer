# Set device background 
Framer.Device.background.backgroundColor = "#FF96A8"

# Import file "multiply" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/multiply@2x")

# Colors
colors = ["#FFDB09", "#06AFE0", "#76C75E", "#F95B26", "#FF96A8"]

# ballA = ball.copy()
# ballA.backgroundColor = colors[1]
# ballA.style = "mix-blend-mode": "multiply"
# 
# ballB = ball.copy()
# ballB.backgroundColor = colors[2]
# ballB.style = "mix-blend-mode": "multiply"
# 
# ballC = ball.copy()
# ballC.backgroundColor = colors[3]
# ballC.style = "mix-blend-mode": "multiply"
# 
# ballD = ball.copy()
# ballD.backgroundColor = colors[4]
# ballD.style = "mix-blend-mode": "multiply"
# 
# ball.draggable.enabled = true
# ball.draggable.horizontal = false
# ball.draggable.constraints =
# 	x: 0
# 	y: 0
# 	width: Screen.width
# 	height: Screen.height
# 
# 
# ball.on "change:y", ->
# 	ballA.y = Utils.modulate @y, [0, Screen.height], [0, Screen.height * .25]
# 	ballB.y = Utils.modulate @y, [0, Screen.height], [0, Screen.height * .5]
# 	ballC.y = Utils.modulate @y, [0, Screen.height], [0, Screen.height * .75]

# Recreation of Fausto Pérez's project:
# share.framerjs.com/njtdbgzk2qbm



for i in [0..4]
	circle = new Layer
		x: Align.center
		width: 425
		height: 425
		borderRadius: "50%"
		backgroundColor: colors[i]
		style:
			"mix-blend-mode": "multiply"
			
	circle.draggable.enabled = yes
	circle.draggable.constraints = Screen.frame
	circle.draggable.horizontal = no
	
	circle.on Events.Move, ->
		for j in [0...this.siblings.length]
			this.siblings[j].y = this.y * (j/this.siblings.length)
