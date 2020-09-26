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

onready var active_bounties: VBoxContainer = get_node("/root/Game/UI/ActiveBounties")

var bounty_index: int
var bounty_cost: int
var current_credits: int
var selected_bounty: Bounty # TODO: Needed ?

func _ready():
	r.connect("credits_changed", self, "_on_credits_changed")
	
func _on_credits_changed(new_resource_value):
	current_credits = new_resource_value
	toggle_send_button()

func _on_MissionSelect_about_to_show():
	create_mission_options($OptionButton)
	set_mission_cost(0)

func create_mission_options(button: OptionButton) -> void:
	# TODO: Generate Bounties here to select from
	# var new_bounty = Bounty.new()
	
	button.clear()
	for option in bounty_options:
		button.add_item(option)

func _on_OptionButton_item_selected(id) -> void:
	set_mission_cost(id)

func set_mission_cost(index) -> void:
	bounty_index = index
	bounty_cost = bounty_spec[bounty_options[bounty_index]].cost
	$CostLabel.text = "Cost: %s" % bounty_cost
	toggle_send_button()

func _on_Send_button_up():
	# TODO: set selected_bounty ?
	r.subtract_credits(bounty_cost)
	hide()
	start_bounty()

func toggle_send_button():
	$Send.disabled = current_credits < bounty_cost

func start_bounty():
	pass
	# Pass bounty details here?
	# active_bounties.add_bounty(new_bounty)
