extends VBoxContainer

const ACTIVE_BOUNTY_SCENE = preload("res://Scenes/ActiveBountyProgress.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func add_bounty(bounty: Bounty):
	var new_bounty_scene = ACTIVE_BOUNTY_SCENE.instance()
	new_bounty_scene.init(bounty)
	add_child(new_bounty_scene)

func complete_bounty():
	pass

func cancel_bounty():
	pass

func gold_rush():
	# Instantly complete bounty?
	# Increase bounty progress step?
	# YEEHAW
	pass
