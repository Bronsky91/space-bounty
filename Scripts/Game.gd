extends Node2D

onready var credits_label = $HUD/UI/CreditsLabel
onready var gold_label = $HUD/UI/GoldLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	r.credits_label = credits_label
	r.gold_label = gold_label
	r.add_credits(100)
	r.add_gold(100)


func _on_BuildRoom_pressed():
	g.set_room_preview_ui(true)
	var rooms = get_node("Fleet/Ship/Rooms/Navigation2D")
	
	for room in rooms.get_children():
		if room.name == "YSort":
			continue
		else:
			print("room: " + room.name)
			for tile in room.get_node("Size/" + c.SIZES[room.size]).get_children():
				var pos = Vector2(room.position.x + tile.position.x, room.position.y + tile.position.y)
				if !tile.neighbor_left and !tile.is_interior_left:
					add_preview_room(c.DIRECTION.right, tile.id, Vector2(pos.x - 128, pos.y))
				if !tile.neighbor_top and !tile.is_interior_top:
					add_preview_room(c.DIRECTION.down, tile.id, Vector2(pos.x, pos.y - 128))
				if !tile.neighbor_right and !tile.is_interior_right:
					add_preview_room(c.DIRECTION.left, tile.id, Vector2(pos.x + 128, pos.y))
				if !tile.neighbor_bottom and !tile.is_interior_bottom:
					add_preview_room(c.DIRECTION.up, tile.id, Vector2(pos.x, pos.y + 128))


func add_preview_room(neighbor_dir: int, neighbor_id: String, pos: Vector2):
	var occupied: bool = false
	for pr in get_node("Fleet/Ship/RoomPreviews").get_children():
		if pr.position == pos:
			occupied = true
			if neighbor_dir == c.DIRECTION.left:
				pr.neighbor_left = neighbor_id
			elif neighbor_dir == c.DIRECTION.up:
				pr.neighbor_top = neighbor_id
			elif neighbor_dir == c.DIRECTION.right:
				pr.neighbor_right = neighbor_id
			elif neighbor_dir == c.DIRECTION.down:
				pr.neighbor_bottom = neighbor_id
	if !occupied:
		var preview_room = load("res://Scenes/RoomPreview.tscn").instance()
		preview_room.position = pos
		if neighbor_dir == c.DIRECTION.left:
			preview_room.neighbor_left = neighbor_id
		elif neighbor_dir == c.DIRECTION.up:
			preview_room.neighbor_top = neighbor_id
		elif neighbor_dir == c.DIRECTION.right:
			preview_room.neighbor_right = neighbor_id
		elif neighbor_dir == c.DIRECTION.down:
			preview_room.neighbor_bottom = neighbor_id
		get_node("Fleet/Ship/RoomPreviews").add_child(preview_room)


func _on_BuildRoomCancel_pressed():
	g.enable_room_preview_ui(false)
	g.clear_room_preview()


func _on_AddCrew_pressed():
	var new_character = c.CHARACTER_SCENE.instance()
	var bridge = get_node("Fleet/Ship/Rooms/Navigation2D/BridgeRoom")
	new_character.nav = get_node("Fleet/Ship/Rooms/Navigation2D")
	new_character.position = bridge.position
	get_node("Fleet/Ship/Rooms/Navigation2D/YSort").add_child(new_character)

