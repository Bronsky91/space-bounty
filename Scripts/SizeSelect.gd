extends WindowDialog

const size_options: Array = [
	"SMALL",
	"LONG",
	"TALL",
	"BIG",
]

var current_selected_size_cost: int
var size_type_index: int

func _ready():
	r.connect("credits_changed", self, "_on_credits_changed")


func _on_credits_changed(new_credits_value: int):
	toggle_resize_room()


func _on_RoomBuildWindowDialog_about_to_show():
	create_size_options($OptionButton)
	set_size_cost(0)


func create_size_options(button: OptionButton) -> void:
	button.clear()
	for option in size_options:
		button.add_item(option)


func _on_OptionButton_item_selected(id) -> void:
	set_size_cost(id)


func set_size_cost(index: int) -> void:
	size_type_index = index
	var size_cost = 0
	$CostLabel.text = "Cost: %s" % size_cost
	current_selected_size_cost = size_cost
	toggle_resize_room()


func toggle_resize_room():
	$ResizeRoom.disabled = current_selected_size_cost > r.credits


func _on_ResizeRoom_pressed():
	get_parent().resize(size_type_index)
	hide()
