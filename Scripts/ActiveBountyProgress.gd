extends Area2D

func _on_Timer_timeout():
	pass # Replace with function body.

func on_click():
	print("Click")
	
# TODO figure out why this isn't firing
func _on_ActiveBountyProgress_input_event(viewport, event, shape_idx):
	if event.is_action_released("left_click"):
		self.on_click()
