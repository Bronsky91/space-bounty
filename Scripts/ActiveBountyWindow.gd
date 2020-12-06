extends Node2D

var bounty_id
var bounty_progress

func _ready():
	g.connect("bounty_progress_update", self, '_on_bounty_progress_update')
	var bounty: Bounty = g.find_bounty_by_id(bounty_id)
	bounty_progress = bounty.progress_percent
	toggle_buttons()
	
func _on_bounty_progress_update(id, value):
	if id == bounty_id:
		bounty_progress = value
		toggle_buttons()

func _on_Cancel_button_up():
	# Is this button meant to Cancel the bounty itself or just hide the bounty window?
	hide()

func _on_Collect_button_up():
	if bounty_progress == 100:
		g.finish_bounty(bounty_id)
		close_out_bounty()

func remove_bounty_progress_bar():
	var progress_bars = get_node('/root/Game/HUD/UI/ActiveBounties').get_children()
	for pg in progress_bars:
		if pg.bounty_id == bounty_id:
			pg.queue_free()

func _on_Rush_button_up():
	gold_rush()

func gold_rush():
	g.gold_rush_bounty(bounty_id)
	close_out_bounty()
	# Instantly complete bounty
	# Increase bounty progress step?
	# YEEHAW

func toggle_buttons():
	$Collect.disabled = bounty_progress != 100
	$Rush.disabled = g.bounty_not_rushable(bounty_id)
	
func close_out_bounty():
		remove_bounty_progress_bar()
		queue_free() # Removes Bounty Window
