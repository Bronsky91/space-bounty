extends WindowDialog

const mission_options: Array = [
	# TODO: Get from API?
]

const mission_spec: Dictionary = {
	# TODO: Mission
}

var mission_index: int

func _ready():
	pass

func _on_MissionSelect_about_to_show():
	create_mission_options($OptionButton)
	set_mission_cost(0)

func create_mission_options(button: OptionButton) -> void:
	for option in mission_options:
		button.add_item(option)
		
func _on_OptionButton_item_selected(id) -> void:
	set_mission_cost(id)

func set_mission_cost(index) -> void:
	mission_index = index
	$CostLabel.text = "Cost: %s" % c.ROOM_SPEC[mission_options[index]].cost

func _on_Send_button_up():
	# TODO: Start mission progress
	hide()
