extends Node

enum DIRECTION {left, up, right, down}

const EMPTY_ROOM = preload("res://Assets/room-empty.jpg")
const ROOM = preload("res://Assets/room-test.jpg")
const CHARACTER_SCENE = preload("res://Scenes/Character.tscn")
const BOUNTY_WINDOW = preload("res://Scenes/ActiveBountyWindow.tscn")

# Room Types
const MISSION: String = 'Mission'
const COMPUTER: String = 'Server Room'
const CREW: String = 'Crew'
const GREEN_HOUSE: String = 'Green House'
const ARMORY: String = 'Armory'
const SB_GREEN: Color = Color(0,1,0,1)
const SB_RED: Color = Color(1,0,0,1)

# Room Sizes
enum SIZE { small,long,tall,big }
const SIZES = ["Small", "Long", "Tall", "Big"]
const SMALL: Vector2 = Vector2(128,128)
const LONG: Vector2 = Vector2(256,128)
const TALL: Vector2 = Vector2(128,256)
const BIG: Vector2 = Vector2(256,256)

# Wall Types
enum WALL { left1,left2,top,right1,right2,bottom }

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
		'cost': 50,
		'type': CREW,
		'rate': 5 # Number of crew members it can house
	},
	COMPUTER: {
		'cost': 50,
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
