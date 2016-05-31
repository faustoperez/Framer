
backgroundA = new BackgroundLayer
	backgroundColor: "rgba(255,255,255,1)"
	
layerB = new Layer
	x: 200
	y: 200
	width: 300
	height: 300
	backgroundColor: "rgba(102,102,255,1)"
	x: 178

layerA = new Layer
	x: 100
	y: 100
	width: 100
	height: 100
	backgroundColor: "rgba(255,102,255,1)"
	borderRadius: "50%"


backgroundA.onMouseMove (event, layer) ->
	layerA.midX = event.offsetX * 1.2
	layerA.midY = event.offsetY * 1.2
	
	layerB.midX = event.offsetX * .5
	layerB.midY = event.offsetY * .5
