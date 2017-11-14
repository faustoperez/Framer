# Variables
audios = ['tracks/SPLHCB1.mp3', 'tracks/SPLHCB2.mp3', 'tracks/SPLHCB3.mp3', 'tracks/SPLHCB4.mp3']
labels = ["Audience sound effects", "Drums, Electric Guitars, Bass", "Lead vocals, Backing vocals", "Lead guitar, French horns"]
tracks = []
gainNodes = []
sliders = []
playing = false

Framer.Defaults.Animation =
   time: .2
   curve: "ease-in-out"

context = new webkitAudioContext 

# Create tracks, gain nodes and connect them to context
for i in [0...4]
	track = new Audio
	track.src = audios[i]
	source = context.createMediaElementSource(track)
	gainNode = context.createGain();
	source.connect(gainNode);
	gainNode.connect(context.destination);
	
	tracks.push(track)
	gainNodes.push(gainNode)

	# Create the sliders
	slider = new SliderComponent
		point: Align.center
		knobSize: 25
		width: 8
		height: 180
		backgroundColor: "#EE4444"
		x: i * 100 + 52
		y: 220
	slider.value = 0.5
	slider.fill.backgroundColor = "rgba(240,201,73,.80)"
	slider.knob.draggable.momentum = false
	sliders.push(slider)


# Play / pause button
play.states =
	default:
		opacity: 1
	hide:
		opacity: 0

pause.states =
	default:
		opacity: 1
	hide:
		opacity: 0

pause.stateSwitch("hide")

play.onClick ->
	if !playing
		for i in [0...4]
			tracks[i].play(context.currentTime)
			playing = true
			play.states.next()
			pause.states.next()
	else
		for i in [0...4]
			tracks[i].pause(context.currentTime)
			playing = false
			play.states.next()
			pause.states.next()


# Track info placeholder text
placeholder = new TextLayer
	text: ""
	width: Screen.width
	height: 30
	color: "#EE4444"
	textAlign: "center"
	fontSize: 18
	fontWeight: 500
	y: 446
	opacity: 0


# Faders behaviour
# Thanks @nvh for the scope tip!
for i in [0...4]
	do (i) ->
		sliders[i].onValueChange ->
			gainNodes[i].gain.value = Math.abs(1 - @value)
		sliders[i].knob.onDragStart ->
			placeholder.text = labels[i]
			placeholder.animate
				opacity: 1
		sliders[i].knob.onDragEnd ->
			placeholder.animate
				opacity: 0