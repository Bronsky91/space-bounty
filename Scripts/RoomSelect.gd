extends WindowDialog

const build_options: Array = [
	c.MISSION,
	c.COMPUTER,
	c.CREW,
	c.ARMORY,
	c.GREEN_HOUSE,
]

var current_credits: int
var current_selected_room_cost: int
var build_type_index: int

func _ready():
	r.connect("credits_changed", self, "_on_credits_changed")
	
func _on_credits_changed(new_credits_value: int):
	current_credits = new_credits_value
	toggle_build_room()

func _on_RoomBuildWindowDialog_about_to_show():
	create_build_options($OptionButton)
	set_room_cost(0)

func create_build_options(button: OptionButton) -> void:
	button.clear()
	for option in build_options:
		button.add_item(option)
		
func _on_OptionButton_item_selected(id) -> void:
	set_room_cost(id)

func set_room_cost(index: int) -> void:
	build_type_index = index
	var room_cost = c.ROOM_SPEC[build_options[index]].cost
	$CostLabel.text = "Cost: %s" % room_cost
	current_selected_room_cost = room_cost
	toggle_build_room()

func _on_BuildRoom_button_up() -> void:
	get_parent().build(c.ROOM_SPEC[build_options[build_type_index]])
	hide()
	
func toggle_build_room():
	$BuildRoom.disabled = current_selected_room_cost > current_credits
