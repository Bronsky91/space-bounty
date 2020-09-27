extends Area2D

func _on_Timer_timeout():
	pass # Replace with function body.

func on_click():
	print("Click")
	
# TODO figure out why this isn't firing
func _on_ActiveBountyProgress_input_event(viewport, event, shape_idx):
	print("_on_ActiveBountyProgress_input_event triggered")
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
