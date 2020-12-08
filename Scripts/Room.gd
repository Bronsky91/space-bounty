extends Node2D

var id: int = 0

var is_productive: bool = false
var type: String
var generation_rate: int
var size: int = c.SIZE.small

export(int, FLAGS, "enabled", "interior_left", "interior_top", "interior_right", "interior_bottom", "neighbor_left", "neighbor_top", "neighbor_right", "neighbor_bottom") var tile_01 = 0
export(int, FLAGS, "enabled", "interior_left", "interior_top", "interior_right", "interior_bottom", "neighbor_left", "neighbor_top", "neighbor_right", "neighbor_bottom") var tile_02 = 0
export(int, FLAGS, "enabled", "interior_left", "interior_top", "interior_right", "interior_bottom", "neighbor_left", "neighbor_top", "neighbor_right", "neighbor_bottom") var tile_03 = 0
export(int, FLAGS, "enabled", "interior_left", "interior_top", "interior_right", "interior_bottom", "neighbor_left", "neighbor_top", "neighbor_right", "neighbor_bottom") var tile_04 = 0

onready var available_positions = get_node("RoomTile/Positions").get_children()


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

