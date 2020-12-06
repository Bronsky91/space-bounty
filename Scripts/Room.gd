extends Node2D

const EMPTY_ROOM = preload("res://Assets/room-empty.jpg")
const ROOM = preload("res://Assets/room-test.jpg")
const CHARACTER_SCENE = preload("res://Scenes/Character.tscn")

var is_productive: bool = false
var type: String
var generation_rate: int
var coord: Vector2

func _ready():
	pass

func produce() -> void:
	$Timer.start()
	$Build.hide()
	$RoomSprite.texture = ROOM

func start_production() -> void:
	is_productive = true
	produce()

func build(specs: Dictionary) -> void:
	r.subtract_credits(specs.cost)
	type = specs.type
	generation_rate = specs.rate
	$Label.text = type
	start_production()
	get_parent().add_room(specs.type) # Tells ship the room is added
	if type == c.MISSION:
		$BountyStart.show()

func _on_Timer_timeout() -> void:
	# If the type of room is a production room then generate resource A on a timer
	if c.PRODUCTION_ROOMS.has(type):
		r.add_credits(generation_rate)
		$FloatTextManager.float_text(generation_rate, true)

func _on_Build_button_up() -> void:
	$RoomSelect.popup()
	
func _on_MissionStart_button_up():
	$BountySelect.popup()

func _on_AddCharacter_button_up():
	var new_character = CHARACTER_SCENE.instance()
	add_child(new_character)
