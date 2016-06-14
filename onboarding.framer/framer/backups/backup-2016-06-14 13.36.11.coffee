


bgcolors = ["#e67e22", "#3498db", "#f1c40f"]

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
	card = new Layer 
		backgroundColor: "transparent"
		width: page.width, height: page.height
		x: (page.width)*i, superLayer: page.content
	
	indicator = new Layer 
		backgroundColor: "#fff"
		width: 12, height: 12
		x: 28 * i, y: 1200
		borderRadius: "50%", opacity: 0.2
		
	# Stay centered regardless of the amount of cards
	indicator.x += (Screen.width / 2) - (12 * amount)
	
	# States
	indicator.states.add(active: {opacity: 1, scale:1.2})
	indicator.states.animationOptions = time: 0.5
	
	# Store indicators in our array
	allIndicators.push(indicator)

# Set indicator for current page
page.snapToPage(page.content.subLayers[0])
current = page.horizontalPageIndex(page.currentPage)
allIndicators[current].states.switch("active")

# Define custom animation curve for page switches
page.animationOptions = curve: "spring(200,22,0)"

# Update indicators
page.on "change:currentPage", ->
	indicator.states.switch("default") for indicator in allIndicators
	current = page.horizontalPageIndex(page.currentPage)
	previous = page.horizontalPageIndex(page.previousPage)
	allIndicators[current].states.switch("active")
	bg.animate
    	properties:
        	backgroundColor: bgcolors[current]
	
	