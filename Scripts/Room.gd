extends Node2D

const EMPTY_ROOM = preload("res://Assets/room-empty.jpg")
const ROOM = preload("res://Assets/room-test.jpg")

var is_productive: bool = false
var type: String
var generation_rate: int

func _ready():
	pass

func start_production() -> void:
	is_productive = true
	produce()

func produce() -> void:
	$Timer.start()
	$Build.hide()
	$RoomSprite.texture = ROOM

func build(specs: Dictionary) -> void:
	r.subtract_resource_b(specs.cost)
	type = specs.type
	generation_rate = specs.rate
	$Label.text = type
	start_production()

func _on_Timer_timeout() -> void:
	r.add_resource_a(generation_rate)

func _on_Build_button_up() -> void:
	$RoomBuildWindowDialog.popup()
	
