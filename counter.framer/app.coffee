###
Fausto Pérez
https://github.com/faustoperez/Framer
https://dribbble.com/faustoperez

Firebase code from by Marc Krenn
https://github.com/marckrenn/framer-Firebase
###


{Firebase} = require 'firebase'

bg = new BackgroundLayer
	backgroundColor: "#009fef"

Utils.insertCSS('@import url(https://fonts.googleapis.com/css?family=Bungee);')


# The required information is located at https://firebase.google.com → Console → YourProject → ...
demoDB = new Firebase
	projectID: "framer-counter" # ... Database → first part of URL
	secret: "h55y3eq6Lqs3iIHrF9XXR9qoQLWnWxAGEgjXtvpd" # ... Project Settings → Database → Database Secrets
	server: "s-usc1c-nss-128.firebaseio.com" # Get this info by setting `server: undefined´ first

cards = []
proxies = []
cardCount = 1

tap = new Layer
	image: "images/tap.svg"
	width: 210
	height: 126
	x: (Align.center) -75
	y: (Align.center) +100

# Create card- and proxy-layers
for i in [0...cardCount]

	card = cards[i] = new Layer
		backgroundColor: "transparent"
		width: Screen.width
		y: Screen.height/cardCount * i
		name: "card#{i}"
		html: "0"
		style:
			fontFamily: "Bungee"
			textAlign: "center"
			fontSize: "6em"
			color: "#ffe10b"
			textShadow: "#ff0035 .01em .01em 0,		 				#ff0035 .02em .02em 0,		 				#ff0035 .03em .03em 0,		 				#ff0035 .04em .04em 0,		 				#ff0035 .05em .05em 0,		 				#ff0035 .06em .06em 0,		 				#ff0035 .07em .07em 0,		 				#ff0035 .08em .08em 0,		 				#b60026 .09em .09em 0,		 				#b60026 .1em .1em 0,
		 				#b60026 .11em .11em 0,
		 				#b60026 .12em .12em 0,
		 				#b60026 .13em .13em 0,
		 				#b60026 .14em .14em 0,
		 				#b60026 .15em .15em 0"
	card.center()	


	# Add a Like onClick
	card.onClick ->

		index = _.indexOf(cards, @) # Get index of the tapped card

		# Add a new child-node at
		demoDB.post("/likeCounts/#{index}", 0) # `post´-method can´t be null, undefined or empty, hence `0´

		# We'll later count all the child-nodes at that path, which is our Like-count (1 child-node = 1 like)


	# Proxy layers are used to `fade´-in Like-counts
	proxy = proxies[i] = new Layer
		parent: card
		visible: false
		name: "proxy#{i}"

	# Proxy is later animated when loading data from Firebase
	proxy.onChange "x", -> @.parent.html = Math.floor(@.x)


# Update ----------------------------------

response = (data, method, path, breadCrumb) ->

	# If the database at `/likeCounts´ is null/empty, create a child for each card
	if data is null
		for i in [0...cardCount]
			demoDB.put("/likeCounts/#{i}", 0)


	if path is "/" # euqals, we´re loading the whole dataset onLoad (fires only once)
		if data? # make sure some data exists

			for card,i in cards
				likes = _.toArray(data[i]).length # convert the `data´-response to an array; get its length

				# This causes the Like count to `fade´-in
				proxies[i].animate
					properties:
						x: likes
					curve: "cubic-bezier(0.86, 0, 0.07, 1)"
					delay: i / 2
					time: .5

	else # euqals, a new like was added (to any card)

		# Let's find out, to wich card the like was added by
		index = breadCrumb[0]

		# Now that we know to which card the like was added, we check how many
		# child-nodes are at that path, which is our Like-count (1 child-node = 1 like)
		demoDB.get "/likeCounts/#{index}", (likes) ->

			cards[index].html = _.toArray(likes).length


# 			Heart animation
			heart = new Layer
				backgroundColor: "transparent"
				html: "❤"
				color: "#fff"
				originZ: -1
				style:
					fontSize: "200px"
					fontWeight: "100"
					textAlign : "center"
					
			heart.center()

			heart.animate
				properties:
					scale: 5
					opacity: 0
				curve: "cubic-bezier(0.215, 0.61, 0.355, 1)"
				time: .5
			
			tap.animate
				properties:
					scale: 1.1
					opacity: 0
				curve: "cubic-bezier(0.215, 0.61, 0.355, 1)"
				time: .5

			heart.onAnimationEnd -> @.destroy()
			tap.onAnimationEnd ->
				tap.animate
					properties:
						scale: 1
						opacity: 1
					curve: "cubic-bezier(0.215, 0.61, 0.355, 1)"
					time: .5


demoDB.onChange("/likeCounts", response) # fires onLoad and onChange



