extends Node2D

export var coord: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	$FloorSprite.modulate.a = 0.5
	$WallTop.modulate.a = 0.5
	$WallBottom.modulate.a = 0.5
	$WallLeft.modulate.a = 0.5
	$WallRight.modulate.a = 0.5
	$BlueOverlay.modulate.a = 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Build_pressed():
	var container = get_node("../../Rooms")
	var room = load("res://Scenes/Room.tscn")
	var instance = room.instance()
	instance.coord = coord
	instance.position = position
	container.call_deferred("add_child", instance)
	g.ship_rooms.append(coord)
	g.enable_room_preview_ui(false)
	g.clear_room_preview()

