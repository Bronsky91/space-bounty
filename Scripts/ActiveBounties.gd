extends VBoxContainer

const ACTIVE_BOUNTY_SCENE = preload("res://Scenes/ActiveBountyProgress.tscn")

func _ready():
	pass

func add_bounty(bounty: Bounty):
	# Adds Bounty Progress bar to the Container
	var new_bounty_scene = ACTIVE_BOUNTY_SCENE.instance()
	new_bounty_scene.init(bounty)
	add_child(new_bounty_scene)

