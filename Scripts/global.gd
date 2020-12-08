extends Node

var bounties_in_progress = []
var bridge_position = Vector2(256,256)
var room_id_tracker = 0

signal bounty_progress_update

func new_room_id():
	room_id_tracker += 1
	return room_id_tracker


func set_tile_neighbor(tile_id: String, neighbor_dir: int, neighbor_id: String):
	var rooms = get_node("/root/Game/Fleet/Ship/Rooms/Navigation2D").get_children()
	for room in rooms:
		if room is YSort:
			continue
		var sizes = room.get_node("Size").get_children()
		for size in sizes:
			if size.get_name() == c.SIZES[room.size]:
				for tile in size.get_children():
					if tile.id == tile_id:
						size.show()
						if neighbor_dir == c.DIRECTION.left:
							tile.neighbor_left = neighbor_id
						elif neighbor_dir == c.DIRECTION.up:
							tile.neighbor_top = neighbor_id
						elif neighbor_dir == c.DIRECTION.right:
							tile.neighbor_right = neighbor_id
						elif neighbor_dir == c.DIRECTION.down:
							tile.neighbor_bottom = neighbor_id
						for wall in tile.get_node("Walls").get_children():
							wall.display()


func exit_room_preview():
	g.set_room_preview_ui(false)
	g.clear_room_preview()


func set_room_preview_ui(enable: bool):
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
				for tile in size.get_children():
					for wall in tile.get_node("Walls").get_children():
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
