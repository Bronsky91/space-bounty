extends WindowDialog

onready var active_bounties: VBoxContainer = get_node("/root/Game/HUD/UI/ActiveBounties")

var bounties: Array
var selected_bounty: Bounty

func _ready():
	bounties = [Bounty.new(1)] # Testing reference script
	r.connect("credits_changed", self, "_on_credits_changed")
	
func _on_credits_changed(new_resource_value):
	if selected_bounty:
		toggle_send_button()

func _on_MissionSelect_about_to_show():
	create_mission_options($OptionButton)
	set_mission_cost(0)

func create_mission_options(button: OptionButton) -> void:
	button.clear()
	for bounty in bounties:
		button.add_item(bounty.name)

func _on_OptionButton_item_selected(index) -> void:
	set_mission_cost(index)

func set_mission_cost(index) -> void:
	if len(bounties) > 0:
		selected_bounty = bounties[index]
		$CostLabel.text = "Cost: %s" % selected_bounty.cost
	else:
		$CostLabel.text = "No Bounties Available"
	toggle_send_button()

func _on_Send_button_up():
	r.subtract_credits(selected_bounty.cost)
	hide()
	start_bounty()

func toggle_send_button():
	$Send.disabled = len(bounties) == 0 or r.credits < selected_bounty.cost

func start_bounty():
	g.apply_in_progress_bounty(selected_bounty)
	active_bounties.add_bounty(selected_bounty)
	bounties.erase(selected_bounty)
	$CostLabel.text = ""
