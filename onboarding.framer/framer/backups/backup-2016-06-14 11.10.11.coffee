pages = new PageComponent
	x: Align.center
	y: Align.center
	scrollVertical: no
	width: Screen.wi

page1 = new Layer
	backgroundColor: "purple"

page2 = new Layer
	backgroundColor: "red"

page3 = new Layer
	backgroundColor: "green"

pages.addPage page1
pages.addPage page2
pages.addPage page3

circle = new Layer
	parent: page1
	x: 62
	width: 77
	y: 212
	height: 78
	borderRadius: 100
	backgroundColor: "rgba(0,255,36,1)"
circle.states.add
	stateA:
		y: 61

square = new Layer
	parent: page2
	x: 62
	y: Align.center
	width: 77
	height: 78
	backgroundColor: "rgba(0,255,36,1)"
square.states.add
	stateA:
		rotation: 90

diamond = new Layer
	parent: page3
	x: 62
	y: Align.center
	width: 77
	height: 78
	scale: 0
	rotation: 45
	backgroundColor: "rgba(0,255,36,1)"
diamond.states.add
	stateA:
		scale: 1

Utils.delay 1, ->
	circle.states.switch "stateA"
	
pages.on "change:currentPage", ->
	switch pages.currentPage
		when page1
			circle.states.switch "stateA"
			square.states.switch "default"
			diamond.states.switch "default"
		when page2
			square.states.switch "stateA"
			circle.states.switch "default"
			diamond.states.switch "default"
		when page3
			diamond.states.switch "stateA"
			square.states.switch "default"
			circle.states.switch "default"