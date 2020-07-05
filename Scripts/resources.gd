extends Node

var resource_a_label: Label
var resource_b_label: Label

var resource_a_text: String = "Resource A: %s"
var resource_b_text: String = "Resource B: %s"

var resource_a: int = 0
var resource_b: int = 0


func _ready():
	pass # Replace with function body.

func add_resource_a(num: int) -> int:
	resource_a += num
	resource_a_label.text = resource_a_text % resource_a
	return resource_a
	
func subtract_resource_a(num: int) -> int:
	resource_a -= num
	resource_a_label.text = resource_a_text % resource_a
	return resource_a
	
func add_resource_b(num: int) -> int:
	resource_b += num
	resource_a_label.text = resource_b_text % resource_b
	return resource_b
	
func subtract_resource_b(num: int) -> int:
	resource_b -= num
	resource_a_label.text = resource_b_text % resource_b
	return resource_b
