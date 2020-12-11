extends Node2D

var id: int = 0

var is_productive: bool = false
var type: String
var generation_rate: int


# Enables door in corresponding wall -- [] only available if wall is 300px and not 150px
#     [T1] T2 [T3]
# [L1]            [R1]
#  L2              R2
# [L3]            [R3]
#     [B1] B2 [B3]
export(int, FLAGS, "L1", "L2", "L3", "T1", "T2", "T3", "R1", "R2", "R3", "B1", "B2", "B3") var doors = 0

onready var available_positions = get_node("Positions").get_children()


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

