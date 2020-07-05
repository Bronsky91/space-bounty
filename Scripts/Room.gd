extends Node2D

var type: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func build(specs: Dictionary):
	type = specs.type
	
	
func _on_Timer_timeout():
	r.add_resource_a(4)
