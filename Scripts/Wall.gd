extends Node2D

export(c.WALL) var wall = c.WALL.top
export var has_door = false
export var has_neighbor = false
onready var room: Node2D = get_node("../../../../..")
onready var tile: Node2D = get_node("../..")
var is_interior: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	display()


func display():
	set_attributes()
	if is_interior:
		hide()
	else:
		show()
		set_texture()
		adjust_position()


func set_attributes():
	if (wall == c.WALL.left1 or wall == c.WALL.left2):
		is_interior = tile.is_interior_left
		has_neighbor = tile.neighbor_left != ""
	elif (wall == c.WALL.top):
		is_interior = tile.is_interior_top
		has_neighbor = tile.neighbor_top != ""
	elif (wall == c.WALL.right1 or wall == c.WALL.right2):
		is_interior = tile.is_interior_right
		has_neighbor = tile.neighbor_right != ""
	elif (wall == c.WALL.bottom):
		is_interior = tile.is_interior_bottom
		has_neighbor = tile.neighbor_bottom != ""
	has_door = has_neighbor


func set_texture():
	if (wall == c.WALL.left1 or wall == c.WALL.right1):
		if(!has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_SideA.png")
		elif(has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_SideB.png")
		elif(!has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_SideA.png")
		elif(has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_SideB.png")
	elif (wall == c.WALL.left2 or wall == c.WALL.right2):
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
	elif (wall == c.WALL.top):
		if(!has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_TopA.png")
		elif(has_door && !has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/Wall_001_TopB.png")
		elif(!has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_TopA.png")
		elif(has_door && has_neighbor):
			$Sprite.texture = load("res://Assets/Ship/Wall/WallThin_001_TopB.png")
	elif (wall == c.WALL.bottom):
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
	if (wall == c.WALL.left1 or wall == c.WALL.left2):
		position = Vector2(-(fs.x / 2) + (ws.x / 2), 0)
	elif (wall == c.WALL.top):
		position = Vector2(0, -(fs.y / 2) + (ws.y / 2))
	elif (wall == c.WALL.right1 or wall == c.WALL.right2):
		position = Vector2((fs.x / 2) - (ws.x / 2), 0)
	elif (wall == c.WALL.bottom):
		position = Vector2(0, (fs.y / 2) - (ws.y / 2))
