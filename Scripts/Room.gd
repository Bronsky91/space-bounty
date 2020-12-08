extends Node2D

var id: int = 0

var is_productive: bool = false
var type: String
var generation_rate: int
var size: int = c.SIZE.small

onready var available_positions = get_node("Size/" + c.SIZES[size] + "/RoomTile/Positions").get_children()


func resize(newSize: int) -> void:
#	g.purge_tiles_by_room_id(room_id)
#	var base_coord: Vector2 = get_node("Size/Small/RoomTile").coord
#	if size == c.SIZE.small:
#		if newSize == c.SIZE.long:
#			for s in get_node("Size").get_children():
#				if s.name == c.SIZES[size]:
#					s.show()
#					for tile in s.get_children():
#						if(tile.name == "RoomTile"):
#							tile.coord = base_coord
#							g.add_tile(base_coord, room_id)
#						elif(tile.name == "RoomTile2"):
#							tile.coord = Vector2(base_coord.x + 1, base_coord.y)
#							g.ship_room_tiles.add(Vector3(base_coord.x + 1, base_coord.y, room_id))
#				else:
#					s.hide()
	pass


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

