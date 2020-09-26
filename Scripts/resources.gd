extends Node

### Note on Resources ###
# Resource A creates Missions # 
# Missions create resource B #
# Resource B creates Rooms #
# Rooms create resource A #

var resource_a_label: Label
var resource_b_label: Label

var resource_a: int
var resource_b: int

var resource_a_text: String = "Resource A: %s"
var resource_b_text: String = "Resource B: %s"

signal resource_a_changed
signal resource_b_changed

func _ready():
	pass

func add_resource_a(num: int) -> int:
	resource_a += num
	resource_a_label.text = resource_a_text % resource_a
	emit_signal("resource_a_changed", resource_a)
	return resource_a
	
func subtract_resource_a(num: int) -> int:
	resource_a -= num
	resource_a_label.text = resource_a_text % resource_a
	emit_signal("resource_a_changed", resource_a)
	return resource_a
	
func add_resource_b(num: int) -> int:
	resource_b += num
	resource_b_label.text = resource_b_text % resource_b
	emit_signal("resource_b_changed", resource_b)
	return resource_b
	
func subtract_resource_b(num: int) -> int:
	resource_b -= num
	resource_b_label.text = resource_b_text % resource_b
	emit_signal("resource_b_changed", resource_b)
	return resource_b
