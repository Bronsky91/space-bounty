extends Node2D

onready var resource_a_label = $UI/ResourceA
onready var resource_b_label = $UI/ResourceB

# Called when the node enters the scene tree for the first time.
func _ready():
	r.resource_a_label = resource_a_label
	r.resource_b_label = resource_b_label

