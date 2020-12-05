class_name Bounty
extends Reference

const uuid_util = preload('res://Scripts/uuid.gd')

var id: String
var name: String
var cost: int
var reward_credits: int
var reward_gold: int
var success_rate: float
var progress_percent: int
var gold_needed_to_rush: int
# Progress %
# [Hunter]
# Reward
# Pic/Description

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Generate new bounty properties based on difficulty level provided
func _init(level):
	id = uuid_util.v4()
	build_bounty(level)
	
func build_bounty(level):
	# This is just a test to set data using the reference script
	
	name = "The High Ghost"
	cost = 40
	reward_credits = 50
	reward_gold = 2
	success_rate = .90
	progress_percent = 0 
	gold_needed_to_rush = 30
