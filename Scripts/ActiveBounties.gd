extends VBoxContainer



var ACTIVE_BOUNTY_SCENE = preload("res://Scenes/ActiveBountyProgress.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_bounty(bounty: Bounty):
	var new_bounty_scene = ACTIVE_BOUNTY_SCENE.instance()
	# TODO: Pass bounty reference instance to scene?
	#add_child(new_bounty_scene

func complete_bounty():
	pass

func cancel_bounty():
	pass

func gold_rush():
	# Instantly complete bounty?
	# Increase bounty progress step?
	# YEEHAW
	pass
