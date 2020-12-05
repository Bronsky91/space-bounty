extends Button

const BOUNTY_WINDOW = preload("res://Scenes/ActiveBountyWindow.tscn")

var bounty_window
var bounty_id
	
func init(bounty: Bounty):
	bounty_id = bounty.id
	$Label.text = bounty.name
	## TODO: Add bount window details here from Bounty reference
	bounty_window = BOUNTY_WINDOW.instance()
	bounty_window.bounty_id = bounty_id
	bounty_window.hide()
	
func _ready():
	# After init add the bounty_window to the scene
	get_node('/root/Game/UI').add_child(bounty_window)

func _on_Timer_timeout():
	$ProgressBar.value += 50

func _on_ProgressBar_value_changed(value):
	g.set_bounty_progress(bounty_id, value)

func _on_ActiveBountyProgress_button_up():
	bounty_window.show()
