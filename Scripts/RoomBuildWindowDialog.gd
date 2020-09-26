extends WindowDialog

const build_options: Array = [
	c.MISSION,
	c.COMPUTER,
	c.CREW,
	c.ARMORY,
	c.GREEN_HOUSE,
]

var current_resource_b: int
var current_selected_room_cost: int
var build_type_index: int

func _ready():
	r.connect("resource_b_changed", self, "_on_Resource_B_changed")
	
func _on_Resource_B_changed(new_resource_value: int):
	print(new_resource_value)
	current_resource_b = new_resource_value
	toggleBuildRoom()

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
	toggleBuildRoom()

func _on_BuildRoom_button_up() -> void:
	get_parent().build(c.ROOM_SPEC[build_options[build_type_index]])
	hide()
	
func toggleBuildRoom():
	$BuildRoom.disabled = current_selected_room_cost > current_resource_b
