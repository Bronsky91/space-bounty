extends WindowDialog

const build_options: Array = [
	c.MISSION,
	c.COMPUTER,
	c.CREW,
	c.ARMORY,
	c.GREEN_HOUSE,
]

var build_type_index: int

func _ready():
	pass

func _on_RoomBuildWindowDialog_about_to_show():
	create_build_options($OptionButton)
	set_room_cost(0)

func create_build_options(button: OptionButton) -> void:
	for option in build_options:
		button.add_item(option)
		
func _on_OptionButton_item_selected(id) -> void:
	set_room_cost(id)

func set_room_cost(index) -> void:
	build_type_index = index
	$CostLabel.text = "Cost: %s" % c.ROOM_SPEC[build_options[index]].cost
	# TODO: Disable send button if the player doesn't have enough resource a

func _on_BuildRoom_button_up() -> void:
	get_parent().build(c.ROOM_SPEC[build_options[build_type_index]])
	hide()
	
