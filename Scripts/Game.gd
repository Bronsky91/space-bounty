extends Node2D

onready var credits_label = $UI/Credits
onready var gold_label = $UI/Gold

# Called when the node enters the scene tree for the first time.
func _ready():
	r.credits_label = credits_label
	r.gold_label = gold_label
	r.add_credits(100)
	r.add_gold(0)
