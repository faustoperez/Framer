

# Variables

$ = Framer

bgcolors = ["#9b59b6", "#3498db", "#2ecc71"]

bg = new BackgroundLayer
	backgroundColor: bgcolors[0]


# Set-up ScrollComponent
page = new PageComponent
	width: Screen.width, height: Screen.height
	y: 0, scrollVertical: false

# Array that will store our layers
allIndicators = []	
amount = 3

# Generate card layers
for i in [0...amount]
	$["card#{i+1}"] = new Layer 
		backgroundColor: "transparent"
		width: page.width, height: page.height
		x: (page.width)*i, superLayer: page.content

	
	indicator = new Layer 
		backgroundColor: "#fff"
		width: 15, height: 15
		x: 40 * i, y: 1200
		borderRadius: "50%", opacity: 0.2
		
	# Stay centered regardless of the amount of cards
	indicator.x += (Screen.width / 2) - (12 * amount)
	
	# States
	indicator.states.add(active: {opacity: 1, scale:1.2})
	indicator.states.animationOptions = time: 0.5
	
	# Store indicators in our array
	allIndicators.push(indicator)



mail = new Layer
	y:550,
	width:99*2, height:104*2
	image:"images/joybox.png"
	superLayer: $.card1
mail.x = Align.center

chispas1 = new Layer
	width:47*2, height:86*2
	image:"images/chispas1.png"
	superLayer: $.card1
	y: 520
	x: 160

chispas2 = new Layer
	width:39*2, height:86*2
	image:"images/chispas2.png"
	superLayer: $.card1
	y: 520
	x: 500

text = new Layer
	width



# Set indicator for current page
page.snapToPage(page.content.subLayers[0])
current = page.horizontalPageIndex(page.currentPage)
allIndicators[current].states.switch("active")

# Define custom animation curve for page switches
page.animationOptions = curve: "spring(200,20,0)"

# Update indicators and bg color
page.on "change:currentPage", ->
	indicator.states.switch("default") for indicator in allIndicators
	current = page.horizontalPageIndex(page.currentPage)
	previous = page.horizontalPageIndex(page.previousPage)
	allIndicators[current].states.switch("active")
	bg.animate
    	properties:
        	backgroundColor: bgcolors[current]


