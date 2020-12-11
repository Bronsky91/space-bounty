extends Node2D

onready var door_bitmask = get_parent().doors
export(String, "001", "002") var wall_num


# Called when the node enters the scene tree for the first time.
func _ready():
	display()


func display():
	set_textures()
	adjust_position()


func set_textures():
	var side_wall = "res://Assets/Ship/Wall/Wall_" + wall_num + "_SideA.png"
	var side_wall_door_high = "res://Assets/Ship/Wall/WallThin_" + wall_num + "_SideB.png"
	var side_wall_door_low = "res://Assets/Ship/Wall/WallThin_" + wall_num + "_SideC.png"
	var top_wall = "res://Assets/Ship/Wall/Wall_" + wall_num + "_TopA.png"
	var top_wall_door = "res://Assets/Ship/Wall/WallThin_" + wall_num + "_TopB.png"
	var bot_wall = "res://Assets/Ship/Wall/Wall_" + wall_num + "_BotA.png"
	var bot_wall_door = "res://Assets/Ship/Wall/WallThin_" + wall_num + "_BotB.png"
	set_tex("L1-A", "L1", side_wall_door_high, side_wall)
	set_tex("L1-B", "L1", side_wall_door_low, "")
	set_tex("L2-A", "L2", side_wall_door_high, side_wall)
	set_tex("L2-B", "L2", side_wall_door_low, "")
	set_tex("L3-A", "L3", side_wall_door_high, side_wall)
	set_tex("L3-B", "L3", side_wall_door_low, "")
	set_tex("T1", "T1", top_wall_door, top_wall)
	set_tex("T2", "T2", top_wall_door, top_wall)
	set_tex("T3", "T3", top_wall_door, top_wall)
	set_tex("R1-A", "R1", side_wall_door_high, side_wall)
	set_tex("R1-B", "R1", side_wall_door_low, "")
	set_tex("R2-A", "R2", side_wall_door_high, side_wall)
	set_tex("R2-B", "R2", side_wall_door_low, "")
	set_tex("R3-A", "R3", side_wall_door_high, side_wall)
	set_tex("R3-B", "R3", side_wall_door_low, "")
	set_tex("B1", "B1", bot_wall_door, bot_wall)
	set_tex("B2", "B2", bot_wall_door, bot_wall)
	set_tex("B3", "B3", bot_wall_door, bot_wall)


func set_tex(node_name: String, wall_name: String, sprite_door: String, sprite_no_door: String):
	var wall = get_node_or_null(node_name + "/Sprite")
	var tilemap = get_node_or_null("../TileMaps/" + wall_name)
	if wall:
		if has_door(wall_name):
			if sprite_door:
				wall.set_texture(load(sprite_door) if sprite_door else null)
			if tilemap:
				tilemap.show()			
		else:
			wall.set_texture(load(sprite_no_door) if sprite_no_door else null)
			if tilemap:
				tilemap.hide()


func has_door(wall: String):
	var walls = ["L1", "L2", "L3", "T1", "T2", "T3", "R1", "R2", "R3", "B1", "B2", "B3"]
	var index = walls.find(wall,0)

	if index == -1:
		return false
	else:
		return door_bitmask & (1 << index) != 0


func adjust_position():
	var floor_sprite = get_node("../FloorSprite")
	var fs = floor_sprite.texture.get_size()
	for wall in get_children():
		var wall_sprite = wall.get_node("Sprite")
		var ws = wall_sprite.texture.get_size() if wall_sprite.texture else Vector2(0,0)
		if wall.name.begins_with("L"):
			wall.position = Vector2(-(fs.x / 2) + (ws.x / 2), 0)
		elif wall.name.begins_with("T"):
			position = Vector2(0, -(fs.y / 2) + (ws.y / 2))
		elif wall.name.begins_with("R"):
			position = Vector2((fs.x / 2) - (ws.x / 2), 0)
		elif wall.name.begins_with("B"):
			position = Vector2(0, (fs.y / 2) - (ws.y / 2))

