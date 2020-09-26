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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _init():
	print('new bounty')

func complete_bounty():
	pass
	
func cancel_bounty():
	pass
	
func gold_rush():
	# Instantly complete bounty?
	# Increase bounty progress step?
	# YEEHAW
	pass
	
