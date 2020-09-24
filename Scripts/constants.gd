extends Node

# Room Types
const MISSION: String = 'Mission'
const COMPUTER: String = 'Server Room'
const CREW: String = 'Crew'
const GREEN_HOUSE: String = 'Green House'
const ARMORY: String = 'Armory'
const SB_GREEN: Color = Color(0,1,0,1)
const SB_RED: Color = Color(1,0,0,1)

# Set Starting Room Specs
const ROOM_SPEC: Dictionary = {
	# Rates do different things per type of Room
	## Times below subject to change, used for example
	MISSION: {
		'cost': 5,
		'type': MISSION,
		'rate': 3, # Number of missions that come in per hour
		# 'room_sprite': ####
	},
	CREW: {
		'cost': 10,
		'type': CREW,
		'rate': 5 # Number of crew members it can house
	},
	COMPUTER: {
		'cost': 20,
		'type': COMPUTER,
		'rate': 10, # Number of resource A generated per minute
	},
	ARMORY: {
		'cost': 10,
		'type': ARMORY,
		'rate': 15 # Number of resource A generated per minute
	},
	GREEN_HOUSE: {
		'cost': 10,
		'type': GREEN_HOUSE,
		'rate': 5 # Number of resource A generated per minute
	},
}

const PRODUCTION_ROOMS = [  # Rooms that produce resource A
	COMPUTER,
	ARMORY,
	GREEN_HOUSE,
]
