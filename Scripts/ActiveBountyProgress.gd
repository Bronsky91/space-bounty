extends Button

var bounty_id
var bounty_window
	
func init(bounty: Bounty):
	bounty_id = bounty.id
	$Label.text = bounty.name
	bounty_window = c.BOUNTY_WINDOW.instance()
	bounty_window.bounty_id = bounty_id
	bounty_window.hide()
	
func _ready():
	# After init add the bounty_window to the scene
	get_node('/root/Game/HUD/UI').add_child(bounty_window)

func _on_Timer_timeout():
	$ProgressBar.value += 1

func _on_ProgressBar_value_changed(value):
	g.set_bounty_progress(bounty_id, value)

func _on_ActiveBountyProgress_button_up():
	bounty_window.show()
