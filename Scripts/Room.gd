extends Node2D

export var coord: Vector2

var is_productive: bool = false
var type: String
var generation_rate: int

onready var available_positions = $Positions.get_children()

func _ready():
	pass

func produce() -> void:
	$Timer.start()
	$Edit.hide()
	#$RoomSprite.texture = c.ROOM

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

