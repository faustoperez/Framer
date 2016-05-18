# Set device background 
Framer.Device.background.backgroundColor = "#FF96A8"

Screen.backgroundColor = "#FEFFDF"

# Colors
colors = ["#FF96A8", "#06AFE0", "#76C75E", "#F95B26", "#FFDB09"]

# 
# Commented is my original code, the solution provided by Robert M http://share.framerjs.com/i1pwuf9kzc9p/ is far more elegant
# 

# ball = new Layer
# 	height: 425
# 	width: 425
# 	borderRadius: "50%"
# 	x: Align.center
# 	y: 0
# 	backgroundColor: colors[0]
# 	style:
# 		"mix-blend-mode": "multiply"
# 
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
# # ball.draggable.horizontal = false
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

for i in [0 ... colors.length]
	circle = new Layer
		name: "circle#{i+1}"
		x: Align.center
		width: 400, height: 400
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

