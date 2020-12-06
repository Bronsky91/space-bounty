extends Node2D

enum WALL { left,top,right,bottom }
export(WALL) var wall = WALL.left
export var has_door = false
export var has_neighbor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	display()


func display():
	set_attributes()
	set_texture()
	adjust_position()


func set_attributes():
	var room = get_parent()
	var neighbor_coord: Vector2
	if (wall == WALL.left):
		neighbor_coord = Vector2(room.coord.x - 1, room.coord.y)
	elif (wall == WALL.top):
		neighbor_coord = Vector2(room.coord.x, room.coord.y - 1)
	elif (wall == WALL.right):
		neighbor_coord = Vector2(room.coord.x + 1, room.coord.y)
	elif (wall == WALL.bottom):
		neighbor_coord = Vector2(room.coord.x, room.coord.y + 1)
		
	if g.ship_rooms.has(neighbor_coord):
		has_neighbor = true
	else:
		has_neighbor = false


func set_texture():
	if (wall == WALL.left or wall == WALL.right):
		if(!has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_SideA.png")
		elif(has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_SideB.png")
		elif(!has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_SideA.png")
		elif(has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_SideB.png")
	elif (wall == WALL.top):
		if(!has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_TopA.png")
		elif(has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_TopB.png")
		elif(!has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_TopA.png")
		elif(has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_TopB.png")
	elif (wall == WALL.bottom):
		if(!has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_BotA.png")
		elif(has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_BotB.png")
		elif(!has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_BotA.png")
		elif(has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_BotB.png")


func adjust_position():
	var floor_sprite = get_node("../FloorSprite")
	var fs = floor_sprite.texture.get_size() # floor size
	var ws = $Sprite.texture.get_size() # wall size
	if (wall == WALL.left):
		position = Vector2(-(fs.x / 2) + (ws.x / 2), 0)
	elif (wall == WALL.top):
		position = Vector2(0, -(fs.y / 2) + (ws.y / 2))
	elif (wall == WALL.right):
		position = Vector2((fs.x / 2) - (ws.x / 2), 0)
	elif (wall == WALL.bottom):
		position = Vector2(0, (fs.y / 2) - (ws.y / 2))
