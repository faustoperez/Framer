# Import file "LM" (sizes and positions are scaled 1:2)
$ = Framer.Importer.load("imported/LM@2x")

bg = new BackgroundLayer
	backgroundColor: "rgba(255,255,255,1)"
	

overlay_menu = new Layer
	y: 216
	width: 2732
	height: 0
	backgroundColor: "rgba(255,255,255,.92)"
	opacity: 1

overlay_menu.superLayer = $.leroy
overlay_menu.placeBefore($.content)

overlay_bg = new Layer
	y: 216
	width: 2732
	height: 1832
	backgroundColor: "rgba(55,62,80,0.95)"
	opacity: 0

overlay_bg.superLayer = $.leroy
overlay_bg.placeBefore($.content)


$.item_on_decoracion.visible = false


# States

overlay_menu.states.add
	open:
		height: 950
		shadowY: 2
		shadowBlur: 3
		shadowSpread: 1
		shadowColor: "rgba(0,0,0,0.2)"

overlay_bg.states.add
	open:
		opacity: 1
		y: 1165
		height: 883

	
for item in $.menu_level_0.subLayers
	item.originY = 3
	item.scale = 1.1 
	item.opacity = 0
	
	item.states.add
		open:
			opacity: 1, scale: 1

for item in $.menu_level_1.subLayers
	item.originY = 3
	item.scale = 1.1 
	item.opacity = 0
	
	item.states.add
		open:
			opacity: 1, scale: 1

for item in $.menu_level_2.subLayers
	item.originY = 3
	item.scale = 1.1 
	item.opacity = 0
	
	item.states.add
		open:
			opacity: 1, scale: 1


# Interaction

closed = true
submenu_closed = true
curve = "spring(500, 40, 0)"

$.products.on Events.Click, ->

	if closed	
		delay = 0
		overlay_menu.states.switch("open", curve: curve, delay: delay)
	else
		delay = 0.1
		overlay_menu.states.switch("default", curve: curve, delay: delay)
		
	if closed	
		delay = 0
		overlay_bg.states.switch("open", curve: curve, delay: delay)
	else
		delay = 0.1
		overlay_bg.states.switch("default", curve: curve, delay: delay)
	
	for item in $.menu_level_0.subLayers

		if closed
			delay = delay + 0.05
			item.states.switch("open", curve: curve, delay: delay)
		else
			delay = delay - 0.05
			item.states.switch("default", curve: curve, delay: delay)

	for item in $.menu_level_1.subLayers

		if closed
			delay = delay + 0.01
			item.states.switch("open", curve: curve, delay: delay)
		else
			delay = delay - 0.01
			item.states.switch("default", curve: curve, delay: delay)
	
	for item in $.menu_level_2.subLayers

		if !closed
			delay = delay - 0.02
			item.states.switch("default", curve: curve, delay: delay)
	
	if $.item_on_decoracion.opacity = 1
		$.item_on_decoracion.opacity = 0
		
			
	if closed
		closed = false
	else
		closed = true


	
$.menu_level_1.on Events.Click, ->
	
	if submenu_closed	
		delay = 0
	else
		delay = 0.2
	
	for item in $.menu_level_2.subLayers

		if submenu_closed && !closed
			$.item_off_decoracion.opacity = 0
			$.item_on_decoracion.visible = true
			$.item_on_decoracion.opacity = 1
			delay = delay + 0.02
			item.states.switch("open", curve: curve, delay: delay)
		else if closed
			$.item_off_decoracion.opacity = 0
		else 
			$.item_off_decoracion.opacity = 1
			$.item_on_decoracion.opacity = 0
			delay = delay - 0.02
			item.states.switch("default", curve: curve, delay: delay)

		
	if submenu_closed
		submenu_closed = false
	else
		submenu_closed = true


overlay_bg.on Events.Click, ->

	if !closed	
		delay = 0.1
		overlay_menu.states.switch("default", curve: curve, delay: delay)
		overlay_bg.states.switch("default", curve: curve, delay: delay)
	
	for item in $.menu_level_0.subLayers

		if !closed
			delay = delay - 0.05
			item.states.switch("default", curve: curve, delay: delay)

	for item in $.menu_level_1.subLayers

		if !closed
			delay = delay - 0.01
			item.states.switch("default", curve: curve, delay: delay)
	
	for item in $.menu_level_2.subLayers

		if !closed
			delay = delay - 0.02
			item.states.switch("default", curve: curve, delay: delay)
	
	if $.item_on_decoracion.opacity = 1
		$.item_on_decoracion.opacity = 0
		
			
	if closed
		closed = false
	else
		closed = true
