
# SETUP

{VRComponent, VRLayer} = require "VRComponent"

# Using six images we create the environment
vr = new VRComponent
	front: "images/front.jpg"
	right: "images/right.jpg"
	left: "images/left.jpg"
	back: "images/back.jpg"
	bottom: "images/bottom.jpg"
	top: "images/top.jpg"
	heading: 88
	elevation: 0
# 	perspective: 1100

# Pointer

pointer = new VRLayer
	width: 70
	height: 70
	borderRadius: 100
	backgroundColor: "transparent"
	borderWidth: 4
	borderColor: "#FEC801"
	x: Align.center
	y: Align.center


# TRIGGERS

window_trigger = new VRLayer
	elevation: 4
	heading: 1

screen_trigger = new VRLayer
	elevation: 5
	heading: 88

table_trigger = new VRLayer
	elevation: -22
	heading: 91

wall_trigger = new VRLayer
	elevation: 0
	heading: 177

flipchart_trigger = new VRLayer
	elevation: -3
	heading: 243

tv_trigger = new VRLayer
	elevation: -1
	heading: 294

postits_trigger = new VRLayer
	elevation: -18
	heading: 266

# Create array from triggers
triggers = [window_trigger, screen_trigger, table_trigger, wall_trigger, flipchart_trigger, tv_trigger, postits_trigger]

# Style triggers via for-loop
for i in [0...triggers.length]
	triggers[i].image = "images/plus.png"
	triggers[i].width = 50
	triggers[i].height = 50
	vr.projectLayer(triggers[i])


# TOOLTIPS

window_tooltip = new VRLayer
	name: "window_tooltip"
	elevation: 8
	heading: 7

screen_tooltip = new VRLayer
	name: "screen_tooltip"
	elevation: 9
	heading: 94

table_tooltip = new VRLayer
	name: "table_tooltip"
	elevation: -18
	heading: 97

wall_tooltip = new VRLayer
	name: "wall_tooltip"
	elevation: 4
	heading: 183

flipchart_tooltip = new VRLayer
	name: "flipchart_tooltip"
	elevation: 1
	heading: 249

tv_tooltip = new VRLayer
	name: "tv_tooltip"
	elevation: 3
	heading: 300

postits_tooltip = new VRLayer
	name: "postits_tooltip"
	elevation: -14
	heading: 272

# Create arrays from tooltips
tooltips = [window_tooltip, screen_tooltip, table_tooltip, wall_tooltip, flipchart_tooltip, tv_tooltip, postits_tooltip]

# Style tooltips via for-loop
for i in [0...tooltips.length]
		
	tooltips[i].image = "images/#{tooltips[i].name}.png"
	tooltips[i].width = 240
	tooltips[i].height = 100
	tooltips[i].originX = 0
	tooltips[i].originY = 1
	
	tooltips[i].states.add
		close:
			scale: 0
			opacity: 0

		open:
			scale: 1
			opacity: 1
	
	tooltips[i].states.switchInstant("close")
	vr.projectLayer(tooltips[i])


# EVENTS
	
# On window resize we make sure the vr component fills the entire screen
window.onresize = ->
	vr.size = Screen.size
	pointer.center()

# Set an event for orientation change
vr.on Events.OrientationDidChange, (data) ->
	heading = data.heading
	elevation = data.elevation
	tilt = data.tilt
	
	curve = "spring(400, 25, 0)"
	
	for i in [0...triggers.length]
		triggerDistance = 2
		headingProximity = Math.abs(heading - triggers[i].heading)
		elevationProximity = Math.abs(elevation - triggers[i].elevation)
		
		if (headingProximity < triggerDistance) && (elevationProximity < triggerDistance)
			tooltips[i].states.switch("open", curve: curve)
		else
			tooltips[i].states.switch("close", curve: curve)



