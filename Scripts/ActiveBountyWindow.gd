extends Node2D

var bounty_id
var bounty_progress

func _ready():
	g.connect("bounty_progress_update", self, '_on_bounty_progress_update')

func _on_bounty_progress_update(id, value):
	if id == bounty_id:
		bounty_progress = value
		$Collect.disabled = bounty_progress != 100
		print(bounty_progress)

func _on_Cancel_button_up():
	hide()

func _on_Collect_button_up():
	if bounty_progress == 100:
		g.finish_bounty(bounty_id)
		remove_bounty_progress_by_id()
		queue_free()

func remove_bounty_progress_by_id():
	var progress_bars = get_node('/root/Game/UI/ActiveBounties').get_children()
	for pg in progress_bars:
		if pg.bounty_id == bounty_id:
			pg.queue_free()

func _on_Rush_button_up():
	pass # Replace with function body.
