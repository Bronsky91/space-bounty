extends Node2D

var ship_rooms = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func add_room(room) -> Array:
	ship_rooms.append(room)
	return ship_rooms

func remove_room(room) -> Array:
	ship_rooms.erase(room)
	return ship_rooms
