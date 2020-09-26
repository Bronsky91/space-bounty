extends VBoxContainer

var ACTIVE_BOUNTY_SCENE = preload("res://Scenes/ActiveBounty.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func add_bounty(bounty: Bounty):
	var new_bounty_scene = ACTIVE_BOUNTY_SCENE.instance()
	var test = bounty
	add_child(new_bounty_scene)
	
func create_progress_bar():
	pass
	
func remove_progress_bar():
	pass
