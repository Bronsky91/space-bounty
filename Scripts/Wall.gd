extends Node2D

enum WALL { left,top,right,bottom }
export(WALL) var wall = WALL.left
export var has_door = false
export var has_neighbor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture()
	adjust_position()


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
	if (wall == WALL.left):
		position = Vector2(position.x + ($Sprite.texture.get_size().x / 2),position.y)
	elif (wall == WALL.top):
		position = Vector2(position.x,position.y + ($Sprite.texture.get_size().y / 2))
	elif (wall == WALL.right):
		position = Vector2(position.x - ($Sprite.texture.get_size().x / 2),position.y)
	elif (wall == WALL.bottom):
		position = Vector2(position.x,position.y - ($Sprite.texture.get_size().y / 2))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
