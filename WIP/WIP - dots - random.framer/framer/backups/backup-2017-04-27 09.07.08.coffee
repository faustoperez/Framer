#background
bg = new BackgroundLayer
	width: Screen.width
	height: Screen.height
	backgroundColor: "#F0F7EF"

# variables
colors = ["#55B247", "#F27589", "#FDC938", "#EF473F", "#75CEDE", "#0089A5"]

amount = 100
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
		y: Utils.randomNumber() * Screen.height -100
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
			y: Utils.randomNumber() * Screen.height
		options:
			time: time
	
	reverseAnimation = forwardAnimation.reverse()

	# Alternate between the two animations 
	forwardAnimation.on Events.AnimationEnd, reverseAnimation.start
	reverseAnimation.on Events.AnimationEnd, forwardAnimation.start
	 
	forwardAnimation.start()