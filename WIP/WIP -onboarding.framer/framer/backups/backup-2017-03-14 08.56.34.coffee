# Project Info

Framer.Info =
	title: "Onboarding"
	author: "Fausto Pérez"
	twitter: "imfausto"
	description: "Lorem ipsum."
	
	
# Variables

bgcolors = ["#9b59b6", "#3498db", "#2ecc71"]
allIndicators = []	
amount = 3

bg = new BackgroundLayer
	backgroundColor: bgcolors[0]

# Set-up PageComponent
page = new PageComponent
	width: Screen.width
	height: Screen.height
	scrollVertical: false


# Generate card layers
for i in [0...amount]
	Framer["card#{i+1}"] = new Layer 
		backgroundColor: "transparent"
		width: page.width
		height: page.height
		x: page.width * i
		superLayer: page.content

	indicator = new Layer 
		backgroundColor: "#fff"
		width: 25
		height: 25
		x: 75 * i
		y: 2000
		borderRadius: "50%"
		opacity: 0.2
		
	# Stay centered regardless of the amount of cards
	indicator.x += (Screen.width / 2) - (30 * amount)
	
	# States
	indicator.states.add(active: {opacity: 1, scale:1.1})
	indicator.states.animationOptions = time: 0.5
	
	# Store indicators in our array
	allIndicators.push(indicator)

mail_ =
	page1:
		y: 700
		x: 500
		scale: 2
	page2:
		y: 700
		x: 1900
		scale: 2.5

mail = new Layer
	y: mail_.page1.y
	image:"images/joybox.png"
	superLayer: Framer.card1
	scale: mail_.page1.scale
	x: mail_.page1.x
	y: mail_.page1.y


# Set indicator for current page
page.snapToPage(page.content.subLayers[0])
current = page.horizontalPageIndex(page.currentPage)
allIndicators[current].states.switch("active")

# Define custom animation curve for page switches
page.animationOptions = curve: "spring(400,40,0)"


# Events
page.on Events.Move, ->
	mail.y = Utils.modulate(page.scrollX, [0, page.width], [mail_.page1.y, mail_.page2.y], true)
	mail.x = Utils.modulate(page.scrollX, [0, page.width], [mail_.page1.x, mail_.page2.x], true)
	mail.scale = Utils.modulate(page.scrollX, [0, page.width], [mail_.page1.scale, mail_.page2.scale], true)


# Update indicators and bg color
page.on "change:currentPage", ->
	indicator.states.switch("default") for indicator in allIndicators
	current = page.horizontalPageIndex(page.currentPage)
	allIndicators[current].states.switch("active")
	bg.animate
		properties:
			backgroundColor: bgcolors[current]