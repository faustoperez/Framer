###
	Login form
	https://dribbble.com/faustoperez

	Background image by Dmitri Popov at https://unsplash.com/@dmpop
	Origami icon from http://www.webalys.com/nova/
	
	Input interaction code from Robert Mion https://share.framerjs.com/d8if88j1qtkm/
	
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
	y: 625
	width: 0
	height: 6
	color: "gray"
	backgroundColor: "transparent"
	style: 
		borderBottom: "3px solid #151515"
	originY: 1

inputPass = new Layer
	x: 74
	y: 790
	width: 0
	height: 6
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



# Initial animations
 
# bg
bg.states.add
    show:
        opacity: 1
        scale: 1.10
 
bg.states.animationOptions =
    delay: .3
 
bg.states.switch("show")

# logo
logo.states.add
    show:
        opacity: 1
        scale: 1
 
logo.states.animationOptions =
    delay: 1
 
logo.states.switch("show")


# bgForm
bgForm.states.add
    show:
        x: 0
 
bgForm.states.animationOptions =
    delay: .75
    time: .4
 
bgForm.states.switch("show")

# inputs

inputUser.states.add
    show:
        opacity: 1
        width: 590
 
inputUser.states.animationOptions =
    delay: 1.4
    time: .2
 
inputUser.states.switch("show")

username.states.add
    show:
        opacity: 1
 
username.states.animationOptions =
    delay: 1.4
    time: .2
 
username.states.switch("show")

inputPass.states.add
    show:
        opacity: 1
        width: 590
 
inputPass.states.animationOptions =
    delay: 1.6
    time: .2
 
inputPass.states.switch("show")

password.states.add
    show:
        opacity: 1
 
password.states.animationOptions =
    delay: 1.6
    time: .2
 
password.states.switch("show")

# button

button.states.add
    show:
        opacity: 1
        scale: 1
 
button.states.animationOptions =
    delay: 1.8
    time: .05
 
button.states.switch("show")


#Interaction
	
# cursor = new Layer
# 	x: 153
# 	maxY: username.maxY - 4
# 	width: 3
# 	height: 25
# 	backgroundColor: "rgba(53,142,28,1)"
# 	opacity: 0
# 
# blinking = new Animation
# 	layer: cursor
# 	properties: 
# 		opacity: 1
# 	time: 0.4
# hidden = blinking.reverse()
# 
# blinking.onAnimationEnd ->
# 	hidden.start()
# hidden.onAnimationEnd ->
# 	blinking.start()
# 
# username.states.animationOptions = time: 0.3
# username.states.add
# 	active:
# 		color: "rgba(53,142,28,1)"
# 		minY: username.minY - 30
# 		height: 60
# 
# username.onClick (event, layer) ->
# 	password.states.switch "default"
# 	username.states.next()
# 	blinking.start()
# 	cursor.maxY = layer.maxY - 4
# 
# password.states.animationOptions = time: 0.3
# password.states.add
# 	active:
# 		color: "rgba(53,142,28,1)"
# 		minY: password.minY - 30
# 		height: 60
# 
# password.onClick (event, layer) ->
# 	username.states.switch "default"
# 	password.states.next()
# 	cursor.maxY = layer.maxY - 4