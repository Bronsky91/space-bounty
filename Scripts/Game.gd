extends Node2D

onready var credits_label = $HUD/UI/CreditsLabel
onready var gold_label = $HUD/UI/GoldLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	r.credits_label = credits_label
	r.gold_label = gold_label
	r.add_credits(100)
	r.add_gold(100)


func _on_AddCrew_pressed():
	var new_character = c.CHARACTER_SCENE.instance()
	var bridge = get_node("Fleet/Ship/Rooms/Navigation2D/BridgeRoom")
	new_character.nav = get_node("Fleet/Ship/Rooms/Navigation2D")
	new_character.position = bridge.position
	get_node("Fleet/Ship/Rooms/Navigation2D/YSort").add_child(new_character)

