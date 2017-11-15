allIndicators = []	
amount = 2

bg = new BackgroundLayer
	backgroundColor: "#fff"

Canvas.backgroundColor = "#EEFAFA"
Framer.Device.phone.style.webkitFilter =
 "drop-shadow(0px 0px 25px rgba(55, 205, 205, .5))"

# Set-up PageComponent
page = new PageComponent
	width: Screen.width
	height: Screen.height
	scrollVertical: false

# Generate card layers
for i in [0...amount]
	window["card#{i+1}"] = new Layer
		name: "card#{i+1}" # display names in layer list
		backgroundColor: "transparent"
		width: page.width
		height: page.height
		x: page.width * i
		superLayer: page.content

	indicator = new Layer 
		backgroundColor: "#000"
		width: 8
		height: 8
		x: 20 * i
		y: 550
		borderRadius: "50%"
		opacity: 0.2
		
	# Stay centered regardless of the amount of cards
	indicator.x += (Screen.width / 2) - (indicator.width * amount)
	
	# States
	indicator.states.add(active: {opacity: 1, scale:1.1})
	indicator.states.animationOptions = time: 0.5
	
	# Store indicators in our array
	allIndicators.push(indicator)


# Set indicator for current page
page.snapToPage(page.content.subLayers[0])
current = page.horizontalPageIndex(page.currentPage)
allIndicators[current].states.switch("active")

# Define custom animation curve for page switches
page.animationOptions = curve: "spring(400,40,0)"

window.card1.index = 2
window.card2.index = 1

# Cup 1
cup1_ =
	page1:
		x: 298
		y: 350
	page2:
		x: 1500
		y: 350

cup1.x = cup1_.page1.x
cup1.y = cup1_.page1.y
cup1.superLayer = window.card1


# Plant
plant_ =
	page1:
		x: 243
		y: 166
	page2:
		x: 1000
		y: 166

plant.x = plant_.page1.x
plant.y = plant_.page1.y
plant.superLayer = window.card1

# Laptop
laptop_ =
	page1:
		x: 197
		y: 248
	page2:
		x: -100
		y: 248
		
laptop.x = laptop_.page1.x
laptop.y = laptop_.page1.y
laptop.superLayer = window.card1

#Text 1
text1.superLayer = window.card1


# Body
body_ =
	page1:
		x: 101
		y: 238
	page2:
		x: 414 + 81
		y: 246

body.x = body_.page1.x
body.y = body_.page1.y
body.superLayer = window.card1

# Head
head_ =
	page1:
		x: 78
		y: 166
		rotation: 0
	page2:
		x: 414 + 58
		y: 174
		rotation: -20

head.x = head_.page1.x
head.y = head_.page1.y
head.superLayer = window.card1

# Host
host_ =
	page1:
		x: 200
		y: 300
	page2:
		x: 210
		y: 116

host.x = host_.page1.x
host.y = host_.page1.y
host.superLayer = window.card2

# Text 2
text2.superLayer = window.card2

# Button
button_ =
	page1:
		x: 1000
		y: 610
	page2:
		x: 80
		y: 610

button.x = button_.page1.x
button.y = button_.page1.y
button.superLayer = window.card2

# Piano
piano.superLayer = window.card2

# Cup2
cup2_ =
	page1:
		x: 5000
		y: 270
	page2:
		x: 241
		y: 270

cup2.x = cup2_.page1.x
cup2.y = cup2_.page1.y
cup2.superLayer = window.card2

# Cup3
cup3_ =
	page1:
		x: 15000
		y: 240
	page2:
		x: 272
		y: 240

cup3.x = cup3_.page1.x
cup3.y = cup3_.page1.y
cup3.superLayer = window.card2


# Events
page.on Events.Move, ->
	body.x = Utils.modulate(page.scrollX, [0, page.width], [body_.page1.x, body_.page2.x], true)
	body.y = Utils.modulate(page.scrollX, [0, page.width], [body_.page1.y, body_.page2.y], true)
	head.x = Utils.modulate(page.scrollX, [0, page.width], [head_.page1.x, head_.page2.x], true)
	head.y = Utils.modulate(page.scrollX, [0, page.width], [head_.page1.y, head_.page2.y], true)
	head.rotation = Utils.modulate(page.scrollX, [0, page.width], [head_.page1.rotation, head_.page2.rotation], true)
	plant.x = Utils.modulate(page.scrollX, [0, page.width], [plant_.page1.x, plant_.page2.x], true)
	plant.y = Utils.modulate(page.scrollX, [0, page.width], [plant_.page1.y, plant_.page2.y], true)
	laptop.x = Utils.modulate(page.scrollX, [0, page.width], [laptop_.page1.x, laptop_.page2.x], true)
	laptop.y = Utils.modulate(page.scrollX, [0, page.width], [laptop_.page1.y, laptop_.page2.y], true)
	cup1.x = Utils.modulate(page.scrollX, [0, page.width], [cup1_.page1.x, cup1_.page2.x], true)
	cup1.y = Utils.modulate(page.scrollX, [0, page.width], [cup1_.page1.y, cup1_.page2.y], true)
	host.x = Utils.modulate(page.scrollX, [0, page.width], [host_.page1.x, host_.page2.x], true)
	host.y = Utils.modulate(page.scrollX, [0, page.width], [host_.page1.y, host_.page2.y], true)
	button.x = Utils.modulate(page.scrollX, [0, page.width], [button_.page1.x, button_.page2.x], true)
	button.y = Utils.modulate(page.scrollX, [0, page.width], [button_.page1.y, button_.page2.y], true)
	cup2.x = Utils.modulate(page.scrollX, [0, page.width], [cup2_.page1.x, cup2_.page2.x], true)
	cup2.y = Utils.modulate(page.scrollX, [0, page.width], [cup2_.page1.y, cup2_.page2.y], true)
	cup3.x = Utils.modulate(page.scrollX, [0, page.width], [cup3_.page1.x, cup3_.page2.x], true)
	cup3.y = Utils.modulate(page.scrollX, [0, page.width], [cup3_.page1.y, cup3_.page2.y], true)


# Update indicators and bg color
page.on "change:currentPage", ->
	indicator.states.switch("default") for indicator in allIndicators
	current = page.horizontalPageIndex(page.currentPage)
	allIndicators[current].states.switch("active")


#### Splash screen ####
splash.placeBefore(indicator)
splash.ignoreEvents = false  # disable scrolling or swiping when the splash screen is still visible

Utils.delay 2.0, ->
	splash.animate
		properties: { opacity: 0.0, scale: 2 }
		time: 0.5
	splash.ignoreEvents = true  
