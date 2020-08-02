extends WindowDialog

const bounty_options: Array = [
	# TODO: Get from API?
	"The High Ghost"
]

const bounty_spec: Dictionary = {
	# TODO: Details for each bounty
	"The High Ghost": {
		"cost": 40
	}
	# cost
	# other attributes
}

var bounty_index: int
var bounty_cost: int

func _ready():
	pass

func _on_MissionSelect_about_to_show():
	create_mission_options($OptionButton)
	set_mission_cost(0)

func create_mission_options(button: OptionButton) -> void:
	for option in bounty_options:
		button.add_item(option)

func _on_OptionButton_item_selected(id) -> void:
	set_mission_cost(id)

func set_mission_cost(index) -> void:
	bounty_index = index
	bounty_cost = bounty_spec[bounty_options[bounty_index]].cost
	$CostLabel.text = "Cost: %s" % bounty_cost
	# TODO: Disable button whenever resource A is less than the bounty cost
			# Needs to setup signal to enable and disable this button on the above condition

func _on_Send_button_up():
	# TODO: Start bounty progress
	r.subtract_resource_a(bounty_cost)
	hide()
