extends Node2D

var id: int = 0

var is_productive: bool = false
var type: String
var generation_rate: int
var size: int = c.SIZE.small

onready var available_positions = get_node("Size/" + c.SIZES[size] + "/RoomTile/Positions").get_children()


func resize(newSize: int) -> void:
	var old = size
	size = newSize
	if old == c.SIZE.small:
		var old_size = get_node("Size/Small")
		var old_tile = get_node("Size/Small/RoomTile")
		if newSize == c.SIZE.long:
			var new_size = get_node("Size/Long")
			var new_tile = get_node("Size/Long/RoomTile")
			var new_tile2 = get_node("Size/Long/RoomTile2")
			new_tile.set_neighbors(old_tile.neighbor_left, old_tile.neighbor_top, new_tile2.id, "")
			new_tile2.set_neighbors(new_tile.id,"",old_tile.neighbor_right, old_tile.neighbor_bottom)
			if(old_tile.neighbor_left):
				g.set_tile_neighbor(old_tile.neighbor_left, c.DIRECTION.right, new_tile.id)
			if(old_tile.neighbor_top):
				g.set_tile_neighbor(old_tile.neighbor_top, c.DIRECTION.down, new_tile.id)
			if(old_tile.neighbor_right):
				g.set_tile_neighbor(old_tile.neighbor_right, c.DIRECTION.left, new_tile2.id)
			if(old_tile.neighbor_bottom):
				g.set_tile_neighbor(old_tile.neighbor_bottom, c.DIRECTION.up, new_tile2.id)
			old_tile.set_neighbors("","","","")
	
	g.seek_missing_neighbors(self)
	g.reposition_rooms()
	g.refresh_walls()


func produce() -> void:
	$Timer.start()
	$Edit.hide()


func start_production() -> void:
	is_productive = true
	produce()


func build(specs: Dictionary) -> void:
	r.subtract_credits(specs.cost)
	type = specs.type
	generation_rate = specs.rate
	$Label.text = type
	start_production()
	get_node("/root/Game/Fleet/Ship").add_room(specs.type) # Tells ship the room is added
	if type == c.MISSION:
		$BountyStart.show()


func _on_Timer_timeout() -> void:
	# If the type of room is a production room then generate resource A on a timer
	if c.PRODUCTION_ROOMS.has(type):
		r.add_credits(generation_rate)
		$FloatTextManager.float_text(generation_rate, true)


func _on_Edit_pressed():
	$RoomSelect.popup()


func _on_MissionStart_button_up():
	$BountySelect.popup()


func free_position(pos):
	if pos:
		available_positions.append(pos)


func take_position(pos):
	available_positions.erase(pos)
	return pos


func _on_Resize_pressed():
	$SizeSelect.popup()

