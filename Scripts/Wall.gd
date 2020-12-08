extends Node2D

enum WALL { left1,left2,top,right1,right2,bottom }
export(WALL) var wall = WALL.top
export var has_door = false
export var has_neighbor = false
onready var room: Node2D = get_node("../../../../..")
onready var tile: Node2D = get_node("../..")
var is_interior: bool = false


func display():
	set_attributes()
	if is_interior:
		print("hiding interior wall!")
		hide()
	else:
		show()
		set_texture()
		adjust_position()


func set_attributes():
	if (wall == WALL.left1 or wall == WALL.left2):
		is_interior = tile.is_interior_left
		has_neighbor = tile.is_neighbor_left
	elif (wall == WALL.top):
		is_interior = tile.is_interior_top
		has_neighbor = tile.is_neighbor_top
	elif (wall == WALL.right1 or wall == WALL.right2):
		is_interior = tile.is_interior_right
		has_neighbor = tile.is_neighbor_right
	elif (wall == WALL.bottom):
		is_interior = tile.is_interior_bottom
		has_neighbor = tile.is_neighbor_bottom
	has_door = has_neighbor


func set_texture():
	if (wall == WALL.left1 or wall == WALL.right1):
		if(!has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_SideA.png")
		elif(has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_SideB.png")
		elif(!has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_SideA.png")
		elif(has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_SideB.png")
	elif (wall == WALL.left2 or wall == WALL.right2):
		if(!has_door && !has_neighbor):
			$Sprite.texture = null
		elif(has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_SideC.png")
			$Sprite.z_index = 1
		elif(!has_door && has_neighbor):
			$Sprite.texture = null
		elif(has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_SideC.png")
			$Sprite.z_index = 1
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
	var floor_sprite = get_node("../../FloorSprite")
	var fs = floor_sprite.texture.get_size() # floor size
	var ws = Vector2(0,0)
	if($Sprite.texture):
		ws = $Sprite.texture.get_size() # wall size
	if (wall == WALL.left1 or wall == WALL.left2):
		position = Vector2(-(fs.x / 2) + (ws.x / 2), 0)
	elif (wall == WALL.top):
		position = Vector2(0, -(fs.y / 2) + (ws.y / 2))
	elif (wall == WALL.right1 or wall == WALL.right2):
		position = Vector2((fs.x / 2) - (ws.x / 2), 0)
	elif (wall == WALL.bottom):
		position = Vector2(0, (fs.y / 2) - (ws.y / 2))
