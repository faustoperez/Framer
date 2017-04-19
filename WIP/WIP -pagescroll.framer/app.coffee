# Background

backgroundA = new BackgroundLayer
Canvas.backgroundColor = "#ffdf9f"


# Variables
pageCount = 3
itemCount = 4
gutter = 10
allMenuItems = []
allScrollItems = []

# Create PageComponent
pageScroller = new PageComponent
	x: 0
	y: Align.center
	width: Screen.width
	height: 440
	scrollHorizontal: false
	clip: false
	directionLock: true


# Loop to create pages
for i in [0...pageCount]
	menuItem = new Layer
		size: pageScroller.size
		y: (pageScroller.height + gutter) * i
		backgroundColor: "transparent"
		parent: pageScroller.content
		opacity: 0.5
		originX: 0
		html: "Category #{i+1}"
		style:
			color: "#000"
			paddingLeft: "20px"
	
	# Add menuItem states

	menuItem.states.add
			active:
				opacity: 1
				scale: 1

	# Create scroll items

	scrollItem = new ScrollComponent
		parent: menuItem
		scrollVertical: false
		directionLock: true
		scale: 0
		opacity: 0
		size: 0
	
	# Add top and bottom inset
	
	scrollItem.contentInset =
		top: 40
		bottom: 20
		left: 20
		right: 20
		
	# Add menuItem states
	
	scrollItem.states.add
		active:
			opacity: 1
			scale: 1
			size: pageScroller.size
	
	# Create image cells
	
	for j in [0...itemCount]

		cell = new Layer
			width: 400
			height: 400
			x: 420 * j
			parent: scrollItem.content
			image:  Utils.randomImage()

	menuItem.animationOptions = curve: "spring(300,30,0)"
	scrollItem.animationOptions = curve: "spring(300,30,0)"
	
	allMenuItems.push(menuItem)
	allScrollItems.push(scrollItem)

# Initialize

allMenuItems[0].stateSwitch("active")
allScrollItems[0].stateSwitch("active")


# Events

pageScroller.on "change:currentPage", ->

	current = pageScroller.verticalPageIndex(pageScroller.currentPage)
	
	menuItem.states.switch("default") for menuItem in allMenuItems
	allMenuItems[current].states.switch("active")
	
	scrollItem.states.switch("default") for scrollItem in allScrollItems
	allScrollItems[current].states.switch("active")
