class_name Bounty
extends Reference


var id: String
var reward_credits: int
var reward_gold: int
var success_rate: int
# Progress %
# [Hunter]
# Reward
# Pic/Description

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Generate new bounty properties based on difficulty level provided
func _init(level):
	print('new bounty')
	
