extends Node2D

onready var credits_label = $UI/Credits
onready var gold_label = $UI/Gold

# Called when the node enters the scene tree for the first time.
func _ready():
	r.credits_label = credits_label
	r.gold_label = gold_label
	r.add_credits(100)
	r.add_gold(100)


func _on_BuildRoom_pressed():
	g.enable_room_preview_ui(true)
	var container = get_node("Fleet/Ship/RoomPreviews")
	var preview_room = load("res://Scenes/RoomPreview.tscn")
	var preview_coords = []
	for coord in g.ship_rooms:
		var left = Vector2(coord.x - 1, coord.y)
		var above = Vector2(coord.x, coord.y - 1)
		var right = Vector2(coord.x + 1, coord.y)
		var below = Vector2(coord.x, coord.y + 1)
		if !preview_coords.has(left) and !g.ship_rooms.has(left):
			preview_coords.append(left)
		if !preview_coords.has(above) and !g.ship_rooms.has(above):
			preview_coords.append(above)
		if !preview_coords.has(right) and !g.ship_rooms.has(right):
			preview_coords.append(right)
		if !preview_coords.has(below) and !g.ship_rooms.has(below):
			preview_coords.append(below)
	for coord in preview_coords:
		var instance = preview_room.instance()
		instance.coord = coord
		instance.position = Vector2(g.helm_position.x + coord.x * 128, g.helm_position.y + coord.y * 128)
		container.call_deferred("add_child", instance)



func _on_BuildRoomCancel_pressed():
	g.enable_room_preview_ui(false)
	g.clear_room_preview()

