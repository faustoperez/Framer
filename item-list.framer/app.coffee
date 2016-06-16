###
Fausto Pérez
https://github.com/faustoperez/Framer
https://dribbble.com/faustoperez
###

# Import file "egg" (sizes and positions are scaled 1:2)
$ = Framer.Importer.load("imported/egg@2x")

colors = ["#f1c40f", "#e74c3c"]

bg = new BackgroundLayer
	backgroundColor: colors[0]

bg.superLayer = $.artboard
bg.placeBehind($.egg)

for item in $.list.subLayers
	item.originY = 3
	item.scale = 1.1 
	item.opacity = 0
	
	item.states.add
		open:
			opacity: 1, scale: 1

# States

$.egg.states.add
	default:
		scale: .9
		x: 27
		y: 164
	open:
		y: -182
		scale: .8
		x: -146

$.eggtext.states.add
	open:
		scale: .6
		y: 331
		x: 342

$.egg.states.switchInstant("default")

# Interaction

closed = true
curve = "spring(250, 25, 0)"

bg.on Events.Click, ->
		
	if closed	
		delay = 0
		$.egg.states.switch("open", curve: curve, delay: delay)
	else
		delay = 0.3
		$.egg.states.switch("default", curve: curve, delay: delay)
		
	if closed	
		delay = 0
		$.eggtext.states.switch("open", curve: curve, delay: delay)
	else
		delay = 0.3
		$.eggtext.states.switch("default", curve: curve, delay: delay)
	
	for item in $.list.subLayers

		if closed
			delay = delay + 0.08
			item.states.switch("open", curve: curve, delay: delay)
		else
			delay = delay - 0.08
			item.states.switch("default", curve: curve, delay: delay)
	
	if closed
		bg.animate
			properties:
				backgroundColor: colors[1]
			time: .5
		closed = false
	else
		bg.animate
			properties:
				backgroundColor: colors[0]
			time: .5
			delay: .3
		closed = true
