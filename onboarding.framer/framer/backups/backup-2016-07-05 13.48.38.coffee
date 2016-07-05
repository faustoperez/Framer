

# Variables

$ = Framer
bgcolors = ["#9b59b6", "#3498db", "#2ecc71"]

bg = new BackgroundLayer
	backgroundColor: bgcolors[0]

# Set-up ScrollComponent
page = new PageComponent
	width: Screen.width
	height: Screen.height
	scrollVertical: false

# Array that will store our layers
allIndicators = []	
amount = 3

# Generate card layers
for i in [0...amount]
	$["card#{i+1}"] = new Layer 
		backgroundColor: "transparent"
		width: page.width
		height: page.height
		x: page.width * i
		superLayer: page.content

	indicator = new Layer 
		backgroundColor: "#fff"
		width: 15
		height: 15
		x: 40 * i
		y: 1200
		borderRadius: "50%"
		opacity: 0.2
		
	# Stay centered regardless of the amount of cards
	indicator.x += (Screen.width / 2) - (15 * amount)
	
	# States
	indicator.states.add(active: {opacity: 1, scale:1.2})
	indicator.states.animationOptions = time: 0.5
	
	# Store indicators in our array
	allIndicators.push(indicator)


mail_ =
	page1:
		y: 420
		x: 276
		scale: 1.4
	page2:
		y: 420
		x: 1030
		scale: 2.5

mail = new Layer
	y: mail_.page1.y,
	width:99*2
	height:104*2
	image:"images/joybox.png"
	superLayer: $.card1
	scale: 1.4
mail.x = Align.center



chispas1 = new Layer
	width:47*2, height:86*2
	image:"images/chispas1.png"
	superLayer: $.card1
	y: 430
	x: 110

chispas2 = new Layer
	width:39*2, height:86*2
	image:"images/chispas2.png"
	superLayer: $.card1
	y: 430
	x: 570

text = new Layer
	width:142*2, height:89*2
	image:"images/text.png"
	superLayer: $.card1
	y: 820
text.x = Align.center

# Set indicator for current page
page.snapToPage(page.content.subLayers[0])
current = page.horizontalPageIndex(page.currentPage)
allIndicators[current].states.switch("active")

# Define custom animation curve for page switches
page.animationOptions = curve: "spring(400,40,0)"

# Events

page.on Events.Move, ->
	
	chispas1.x	= 160 + (page.scrollX * 2)
	chispas2.x = 500 + (page.scrollX * 2)
	text.x = 233 + (page.scrollX * -2)

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


