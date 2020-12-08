extends Node2D

var neighbor_left: String = ""
var neighbor_top: String = ""
var neighbor_right: String = ""
var neighbor_bottom: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	$FloorSprite.modulate.a = 0.5
	$WallTop.modulate.a = 0.5
	$WallBottom.modulate.a = 0.5
	$WallLeft.modulate.a = 0.5
	$WallRight.modulate.a = 0.5
	$BlueOverlay.modulate.a = 0.5


func _on_Build_pressed():
	var rooms = get_node("../../Rooms/Navigation2D")
	var room = load("res://Scenes/Room.tscn").instance()
	var tile = room.get_node("Size/Small/RoomTile")
	rooms.add_child(room)
	room.position = position
	room.id = g.new_room_id()
	if neighbor_left:
		tile.neighbor_left = neighbor_left
		g.set_tile_neighbor(neighbor_left, c.DIRECTION.right, tile.id)
	if neighbor_top:
		tile.neighbor_top = neighbor_top
		g.set_tile_neighbor(neighbor_top, c.DIRECTION.down, tile.id)
	if neighbor_right:
		tile.neighbor_right = neighbor_right
		g.set_tile_neighbor(neighbor_right, c.DIRECTION.left, tile.id)
	if neighbor_bottom:
		tile.neighbor_bottom = neighbor_bottom
		g.set_tile_neighbor(neighbor_bottom,c.DIRECTION.up, tile.id)
	
	
	var last_index = room.get_index()
	var ysort = get_node('../../Rooms/Navigation2D/YSort')
	rooms.move_child(ysort, last_index + 1)
	g.exit_room_preview()

