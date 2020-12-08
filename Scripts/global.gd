extends Node

var bounties_in_progress = []
var helm_position = Vector2(256,256)
var ship_rooms = [Vector2(0,0)]
var size = "Small"

signal bounty_progress_update


func enable_room_preview_ui(enable: bool):
	if enable:
		get_node("/root/Game/HUD/UI/BuildRoom").visible = false
		get_node("/root/Game/HUD/UI/BuildRoomCancel").visible = true
	else:
		get_node("/root/Game/HUD/UI/BuildRoomCancel").visible = false
		get_node("/root/Game/HUD/UI/BuildRoom").visible = true


func clear_room_preview():
	var rooms = get_node("/root/Game/Fleet/Ship/Rooms/Navigation2D").get_children()
	var room_previews = get_node("/root/Game/Fleet/Ship/RoomPreviews").get_children()
	for room_preview in room_previews:
		room_preview.queue_free()
	for room in rooms:
		if room is YSort:
			continue
		var sizes = room.get_node("Size").get_children()
		for size in sizes:
			if size.get_name() == c.SIZES[room.size]:
				size.show()
				var walls = size.get_node("Walls").get_children()
				for wall in walls:
					wall.display()
			else:
				size.hide()


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
	emit_signal("bounty_progress_update", id, value)

func finish_bounty(id):
	var bounty: Bounty = find_bounty_by_id(id)
	# TODO: implement bounty.success_rate
	r.add_credits(bounty.reward_credits)
	r.add_gold(bounty.reward_gold)

func bounty_not_rushable(id):
	var bounty: Bounty = find_bounty_by_id(id)
	return r.gold < bounty.gold_needed_to_rush
	
func gold_rush_bounty(id):
	var bounty: Bounty = find_bounty_by_id(id)
	r.subtract_gold(bounty.gold_needed_to_rush)
	r.add_credits(bounty.reward_credits)
	r.add_gold(bounty.reward_gold)


func files_in_dir(path: String, keyword: String = "") -> Array:
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif keyword != "" and file.find(keyword) == -1:
			continue
		elif not file.begins_with(".") and not file.ends_with(".import"):
			files.append(file)
	dir.list_dir_end()
	return files
