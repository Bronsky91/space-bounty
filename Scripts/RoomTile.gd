extends Node2D

const uuid_util = preload('res://Scripts/uuid.gd')

export var is_interior_left: bool = false
export var is_interior_top: bool = false
export var is_interior_right: bool = false
export var is_interior_bottom: bool = false
var neighbor_left: String = ""
var neighbor_top: String = ""
var neighbor_right: String = ""
var neighbor_bottom: String = ""
var id: String

# Called when the node enters the scene tree for the first time.
func _ready():
	id = uuid_util.v4()


func set_neighbors(left, top, right, bottom):
	neighbor_left = left
	neighbor_top = top
	neighbor_right = right
	neighbor_bottom = bottom


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
