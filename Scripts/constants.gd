extends Node

# Room Types
const MISSION: String = 'Mission'
const COMPUTER: String = 'Computer'
const CREW: String = 'Crew'

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
	COMPUTER: {
		'cost': 20,
		'type': COMPUTER,
		'rate': 10, # Number of resource A generated per minute
	},
	CREW: {
		'cost': 10,
		'type': CREW,
		'rate': 5 # Number of crew members it can house
	}
}
