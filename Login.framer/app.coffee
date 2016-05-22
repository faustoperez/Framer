###
	Login form
	https://dribbble.com/faustoperez

	Background image by Dmitri Popov at https://unsplash.com/@dmpop
	Origami icon from http://www.webalys.com/nova/
	
	Interaction based on Robert Mion's prototype https://share.framerjs.com/d8if88j1qtkm/
	
###

# Set device background 
Framer.Device.background.backgroundColor = "#FFCE0A"

# Import file "01 - login" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/01 - login@2x")

Framer.Defaults.Animation =
    curve: "spring(200,20,0)"

{logo, username, password, button, bgForm, bg} = sketch

inputUser = new Layer
	x: 74
	y: 520
	width: 0
	height: 100
	color: "gray"
	backgroundColor: "transparent"
	style: 
		borderBottom: "3px solid #151515"
	originY: 1

inputPass = new Layer
	x: 74
	y: 680
	width: 0
	height: 100
	color: "gray"
	backgroundColor: "transparent"
	style: 
		borderBottom: "3px solid #151515"
	originY: 1

# Initial states

bg.opacity = 0
bg.scale = 0

bgForm.x = -750

logo.opacity = 0
logo.scale = 0
username.opacity = 0
password.opacity = 0

inputUser.opacity = 0
inputPass.opacity = 0

button.opacity = 0
button.scale = 0

 
# Initial animation

bg.animate
    properties:
        opacity: 1
        scale: 1.10
    delay: .3

logo.animate
    properties:
        opacity: 1
        scale: 1
    delay: 1

bgForm.animate
    properties:
        x: 0
    delay: .75
    time: .4

inputUser.animate
    properties:
        opacity: 1
        width: 590
    delay: 1.4
    time: .2

username.animate
    properties:
        opacity: 1
    delay: 1.4
    time: .2

inputPass.animate
    properties:
        opacity: 1
        width: 590
    delay: 1.6
    time: .2

password.animate
	properties:
		opacity: 1
	delay: 1.6
	time: .2

button.animate
	properties:
		opacity: 1
		scale: 1
	delay: 1.8
	time: .5


# Interaction
	
cursor = new Layer
	x: 74
	maxY: inputUser.maxY
	width: 3
	height: 50
	backgroundColor: "#151515"
	opacity: 0

blinking = new Animation
	layer: cursor
	properties: 
		opacity: 1
	curve: "ease"
	time: 0.4
hidden = blinking.reverse()

blinking.onAnimationEnd ->
	hidden.start()
hidden.onAnimationEnd ->
	blinking.start()

username.states.add
	blur:
		y: 582
		opacity: 1
		scale: 1
	focus:
		y: 517
		opacity: .25

password.states.add
	blur:
		y: 736
		opacity: 1
	focus:
		y: 671
		opacity: .25

inputUser.states.animationOptions = time: 0.3
inputUser.states.add
	active:
		minY: username.minY - 30
		height: 100

inputUser.onClick (event, layer) ->
	password.states.switch("blur")
	username.states.switch("focus")
	blinking.start()
	cursor.maxY = layer.maxY - 20

inputPass.states.animationOptions = time: 0.3
inputPass.states.add
	active:
		minY: password.minY - 30
		height: 100

inputPass.onClick (event, layer) ->
	username.states.switch("blur")
	password.states.switch("focus")
	cursor.maxY = layer.maxY - 20
