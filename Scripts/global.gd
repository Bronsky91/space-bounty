extends Node

# TODO: Array of in progress bounties
# TODO: func finish_bounty(id): finishes bounty in progress

var bounties_in_progress = []

signal bounty_progress_update

func apply_in_progress_bounty(bounty: Bounty):
	bounties_in_progress.append(bounty)

func find_bounty_by_id(id):
	for bounty in bounties_in_progress:
		if bounty.id == id:
			return bounty

func get_bounty_progress(id):
	var bounty: Bounty = find_bounty_by_id(id)
	return bounty.progress_percent
	
func set_bounty_progress(id, value):
	var bounty: Bounty = find_bounty_by_id(id)
	bounty.progress_percent = value
	print(value)
	print('emit bounty_progress_update')
	emit_signal("bounty_progress_update", id, value)

func finish_bounty(id):
	var bounty: Bounty = find_bounty_by_id(id)
	# TODO: implement bounty.success_rate
	r.add_credits(bounty.reward_credits)
	r.add_gold(bounty.reward_gold)
	
