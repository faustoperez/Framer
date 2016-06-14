

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
	y:420,
	width:99*2, height:104*2
	image:"images/joybox.png"
	superLayer: $.card1
mail.x = Align.center

chispas1 = new Layer
	width:47*2, height:86*2
	image:"images/chispas1.png"
	superLayer: $.card1
	y: 430
	x: 160

chispas2 = new Layer
	width:39*2, height:86*2
	image:"images/chispas2.png"
	superLayer: $.card1
	y: 430
	x: 500

text = new Layer
	width:142*2, height:89*2
	image:"images/text.png"
	superLayer: $.card1
	y: 690
text.x = Align.center


# Set indicator for current page
page.snapToPage(page.content.subLayers[0])
current = page.horizontalPageIndex(page.currentPage)
allIndicators[current].states.switch("active")

# Define custom animation curve for page switches
page.animationOptions = curve: "spring(200,20,0)"

print text.x

page.on Events.Move, ->
	
		chispas1.x	= 160 + (page.scrollX * 2)
		chispas2.x = 500 + (page.scrollX * 2)
		text.x = 233 + (page.scrollX * 2)
		
	
# 	from page 1 to page 2
# 	weather.x		= 37*2	+ ( page.scrollX * 1.7 )
# 	instagram.x	= 25*2	+ ( page.scrollX * 1.5 )
# 	rss_feed.x		= 45*2	+ ( page.scrollX * 0.9 )
# 	facebook.x		= 241*2	+ ( page.scrollX * 0.55 )
# 	calendar.x		= 203*2	+ ( page.scrollX * 1.3 )
# 	gmail.x			= 270*2	+ ( page.scrollX * 0.4 )
# 	stocks.x		= 230*2	+ ( page.scrollX * 1.5 )
# 	soundcloud.x	= 246*2	+ ( page.scrollX * 1 )
# 	
# 	from page 2 to page 3
# 	recipe_marker.x = Utils.modulate(page.scrollX, [page.width*1, page.width*2], 
# 						[25*2, (25*2) + page.width], true)
# 	instagram_to_dropbox.x = Utils.modulate(page.scrollX, [page.width*1, page.width*2], 
# 						[17*2, (17*2) + page.width], true)




# Update indicators and bg color
page.on "change:currentPage", ->
	indicator.states.switch("default") for indicator in allIndicators
	current = page.horizontalPageIndex(page.currentPage)
# 	previous = page.horizontalPageIndex(page.previousPage)
	allIndicators[current].states.switch("active")
	bg.animate
    	properties:
        	backgroundColor: bgcolors[current]


