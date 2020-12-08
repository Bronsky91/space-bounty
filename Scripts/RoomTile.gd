extends Node2D

const uuid_util = preload('res://Scripts/uuid.gd')

var id: String

var is_enabled: bool
var is_interior_left: bool
var is_interior_top: bool
var is_interior_right: bool
var is_interior_bottom: bool
var is_neighbor_left: bool
var is_neighbor_top: bool
var is_neighbor_right: bool
var is_neighbor_bottom: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	id = uuid_util.v4()
	
	var mask
	var room = get_parent()
	if name == "RoomTile":
		mask = room.tile_01
	elif name == "RoomTile2":
		mask = room.tile_02
	elif name == "RoomTile3":
		mask = room.tile_03
	elif name == "RoomTile4":
		mask = room.tile_04
		
	is_enabled = is_bit_enabled(mask,0)
	is_interior_left = is_bit_enabled(mask,1)
	is_interior_top = is_bit_enabled(mask,2)
	is_interior_right = is_bit_enabled(mask,3)
	is_interior_bottom = is_bit_enabled(mask,4)
	is_neighbor_left = is_bit_enabled(mask,5)
	is_neighbor_top = is_bit_enabled(mask,6)
	is_neighbor_right = is_bit_enabled(mask,7)
	is_neighbor_bottom = is_bit_enabled(mask,8)
	
	for wall in get_node("Walls").get_children():
		wall.display()
	
	if not is_enabled:
		hide()
		set_process(false)
	else:
		show()
		set_process(true)

func is_bit_enabled(mask, index):
	return mask & (1 << index) != 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
