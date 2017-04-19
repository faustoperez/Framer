contrastContainer = new Layer
	size: Screen.size
	backgroundColor: "#fff"
	contrast: 4000

mainButton = new Layer
	size: 300
	maxX: Screen.width - 60
	maxY: Screen.height - 80
	borderRadius: 100
	backgroundColor: "rgba(215,131,255,1)"
	blur: 20
	parent: contrastContainer

subButtonArray = []
for i in [0..2]
	subButton = new Layer
		parent: contrastContainer
	subButton.props = mainButton.props
	subButton.states.add
		clicked:
			maxY: Screen.height - 80 - (i+1) * mainButton.height
	subButton.states.animationOptions =
		curve: "spring(150,12,0)"
	subButtonArray.push(subButton)

mainButton.onClick ->
	for layer in subButtonArray
		layer.states.next()