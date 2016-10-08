mc = require 'minecraft-protocol'
jwt = require 'jsonwebtoken'

server = mc.createServer version: '1.10'

server.on 'login', (client) ->
	client.write 'login',
		entityId: client.id
		levelType: 'default'
		gameMode: 0
		dimension: 0
		difficulty: 2
		maxPlayers: server.maxPlayers
		reducedDebugInfo: false
	client.write 'position',
		x: 0
		y: 1.62
		z: 0
		yaw: 0
		pitch: 0
		flags: 0x00
	msg = 
		text: "Click here to log in!"
		color: "dark_green"
		clickEvent:
			action: "open_url"
			value: "http://example.com/auth/#{jwt.sign({uuid: client.uuid}, process.env.SECRET_KEY, expiresIn: '5m')}"
	client.write 'chat',
		message: JSON.stringify(msg)
		position: 0
