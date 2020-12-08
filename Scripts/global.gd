extends Node

var bounties_in_progress = []
var bridge_position = Vector2(256,256)
var room_id_tracker = 0

signal bounty_progress_update

func new_room_id():
	room_id_tracker += 1
	return room_id_tracker


func get_tile_room(tile_id: String):
	var rooms = get_node("/root/Game/Fleet/Ship/Rooms/Navigation2D").get_children()
	for room in rooms:
		if room is YSort:
			continue
		for size in room.get_node("Size").get_children():					
				for tile in size.get_children():
					if tile.id == tile_id:
						return room


func get_tile_name(tile_id: String):
	var rooms = get_node("/root/Game/Fleet/Ship/Rooms/Navigation2D").get_children()
	for room in rooms:
		if room is YSort:
			continue
		for size in room.get_node("Size").get_children():					
				for tile in size.get_children():
					if tile.id == tile_id:
						return tile.name


# LEANING HACK OF PISA
func get_neighbor_pos(neighbor_id, neighbor_dir, tile_name, room_size, room_pos, room_id):
	var neighbor = get_tile_room(neighbor_id)
	if(neighbor.id == room_id):
		return room_pos
	var neighbor_tile_name = get_tile_name(neighbor_id)
	if room_size == c.SIZE.small and neighbor.size == c.SIZE.small:
		if neighbor_dir == c.DIRECTION.left:
			return Vector2(room_pos.x - 128, room_pos.y)
		elif neighbor_dir == c.DIRECTION.up:
			return Vector2(room_pos.x, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.right:
			return Vector2(room_pos.x + 128, room_pos.y)
		elif neighbor_dir == c.DIRECTION.down:
			return Vector2(room_pos.x, room_pos.y + 128)
	elif room_size == c.SIZE.small and neighbor.size == c.SIZE.long:
		if neighbor_dir == c.DIRECTION.left:
			return Vector2(room_pos.x - 256, room_pos.y)
		elif neighbor_dir == c.DIRECTION.up:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y - 128)
			elif neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.right:
			return Vector2(room_pos.x + 128, room_pos.y)
		elif neighbor_dir == c.DIRECTION.down:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y + 128)
			elif neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y + 128)
	elif room_size == c.SIZE.small and neighbor.size == c.SIZE.tall:
		if neighbor_dir == c.DIRECTION.left:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x - 128, room_pos.y)
			elif neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.up:
			return Vector2(room_pos.x, room_pos.y - 256)
		elif neighbor_dir == c.DIRECTION.right:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x + 128, room_pos.y)
			elif neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x + 128, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.down:
			return Vector2(room_pos.x, room_pos.y + 128)
	elif room_size == c.SIZE.small and neighbor.size == c.SIZE.big:
		if neighbor_dir == c.DIRECTION.left:
			if neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 256, room_pos.y)
			elif neighbor_tile_name == "RoomTile4":
				return Vector2(room_pos.x - 256, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.up:
			if neighbor_tile_name == "RoomTile3":
				return Vector2(room_pos.x, room_pos.y - 256)
			elif neighbor_tile_name == "RoomTile4":
				return Vector2(room_pos.x - 128, room_pos.y - 256)
		elif neighbor_dir == c.DIRECTION.right:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x + 128, room_pos.y)
			elif neighbor_tile_name == "RoomTile3":
				return Vector2(room_pos.x + 128, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.down:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y + 128)
			elif neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y + 128)
	elif room_size == c.SIZE.long and neighbor.size == c.SIZE.small:
		if neighbor_dir == c.DIRECTION.left:
			return Vector2(room_pos.x - 128, room_pos.y)
		elif neighbor_dir == c.DIRECTION.up:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y - 128)
			elif tile_name == "RoomTile2":
				return Vector2(room_pos.x + 128, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.right:
			return Vector2(room_pos.x + 256, room_pos.y)
		elif neighbor_dir == c.DIRECTION.down:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y + 128)
			elif tile_name == "RoomTile2":
				return Vector2(room_pos.x + 128, room_pos.y + 128)
	elif room_size == c.SIZE.long and neighbor.size == c.SIZE.long:
		if neighbor_dir == c.DIRECTION.left:
			return Vector2(room_pos.x - 256, room_pos.y)
		elif neighbor_dir == c.DIRECTION.up:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y - 128)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y - 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x + 128, room_pos.y - 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.right:
			return Vector2(room_pos.x + 256, room_pos.y)
		elif neighbor_dir == c.DIRECTION.down:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y + 128)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y + 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x + 128, room_pos.y + 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x, room_pos.y + 128)
	elif room_size == c.SIZE.long and neighbor.size == c.SIZE.tall:
		if neighbor_dir == c.DIRECTION.left:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x - 128, room_pos.y)
			elif neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.up:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y - 256)
			elif tile_name == "RoomTile2":
				return Vector2(room_pos.x + 128, room_pos.y - 256)
		elif neighbor_dir == c.DIRECTION.right:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x + 256, room_pos.y)
			elif neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x + 256, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.down:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y + 128)
			elif tile_name == "RoomTile2":
				return Vector2(room_pos.x + 128, room_pos.y + 128)
	elif room_size == c.SIZE.long and neighbor.size == c.SIZE.big:
		if neighbor_dir == c.DIRECTION.left:
			if neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 256, room_pos.y)
			elif neighbor_tile_name == "RoomTile4":
				return Vector2(room_pos.x - 256, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.up:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTile3":
				return Vector2(room_pos.x, room_pos.y - 256)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTile4":
				return Vector2(room_pos.x - 128, room_pos.y - 256)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTile3":
				return Vector2(room_pos.x + 128, room_pos.y - 256)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTile4":
				return Vector2(room_pos.x, room_pos.y - 256)
		elif neighbor_dir == c.DIRECTION.right:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x + 256, room_pos.y)
			elif neighbor_tile_name == "RoomTile3":
				return Vector2(room_pos.x + 256, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.down:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y + 128)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y + 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x + 128, room_pos.y + 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x, room_pos.y + 128)
	elif room_size == c.SIZE.tall and neighbor.size == c.SIZE.small:
		if neighbor_dir == c.DIRECTION.left:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x - 128, room_pos.y)
			elif tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y + 128)
		elif neighbor_dir == c.DIRECTION.up:
				return Vector2(room_pos.x, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.right:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x + 128, room_pos.y)
			elif tile_name == "RoomTile2":
				return Vector2(room_pos.x + 128, room_pos.y + 128)
		elif neighbor_dir == c.DIRECTION.down:
			return Vector2(room_pos.x, room_pos.y + 256)
	elif room_size == c.SIZE.tall and neighbor.size == c.SIZE.long:
		if neighbor_dir == c.DIRECTION.left:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x - 256, room_pos.y)
			elif tile_name == "RoomTile2":
				return Vector2(room_pos.x - 256, room_pos.y + 128)
		elif neighbor_dir == c.DIRECTION.up:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y - 128)
			elif neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.right:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x + 128, room_pos.y)
			elif tile_name == "RoomTile2":
				return Vector2(room_pos.x + 128, room_pos.y + 128)
		elif neighbor_dir == c.DIRECTION.down:
			if neighbor_tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y + 256)
			elif neighbor_tile_name == "RoomTile2":
				return Vector2(room_pos.x - 128, room_pos.y + 256)
	elif room_size == c.SIZE.tall and neighbor.size == c.SIZE.tall:
		if neighbor_dir == c.DIRECTION.left:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x - 128, room_pos.y)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 128, room_pos.y - 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x - 128, room_pos.y + 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 128, room_pos.y)
		elif neighbor_dir == c.DIRECTION.up:
			return Vector2(room_pos.x, room_pos.y - 256)
		elif neighbor_dir == c.DIRECTION.right:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 128, room_pos.y)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x + 128, room_pos.y - 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 128, room_pos.y + 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x + 128, room_pos.y)
		elif neighbor_dir == c.DIRECTION.down:
			return Vector2(room_pos.x, room_pos.y + 256)
	elif room_size == c.SIZE.tall and neighbor.size == c.SIZE.big:
		if neighbor_dir == c.DIRECTION.left:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 256, room_pos.y)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle4":
				return Vector2(room_pos.x - 256, room_pos.y - 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 256, room_pos.y + 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle4":
				return Vector2(room_pos.x - 256, room_pos.y)
		elif neighbor_dir == c.DIRECTION.up:
			if neighbor_tile_name == "RoomTitle3":
				return Vector2(room_pos.x, room_pos.y - 256)
			elif neighbor_tile_name == "RoomTitle4":
				return Vector2(room_pos.x - 128, room_pos.y - 256)
		elif neighbor_dir == c.DIRECTION.right:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 128, room_pos.y)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle3":
				return Vector2(room_pos.x + 128, room_pos.y - 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 128, room_pos.y + 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle3":
				return Vector2(room_pos.x + 128, room_pos.y)
		elif neighbor_dir == c.DIRECTION.down:
			if neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x, room_pos.y + 128)
			elif neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 128, room_pos.y + 128)
	elif room_size == c.SIZE.big and neighbor.size == c.SIZE.small:
		if neighbor_dir == c.DIRECTION.left:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x - 128, room_pos.y)
			elif tile_name == "RoomTile3":
				return Vector2(room_pos.x - 128, room_pos.y + 128)
		elif neighbor_dir == c.DIRECTION.up:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y - 128)
			elif tile_name == "RoomTile2":
				return Vector2(room_pos.x + 128, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.right:
			if tile_name == "RoomTile2":
				return Vector2(room_pos.x + 256, room_pos.y)
			elif tile_name == "RoomTile4":
				return Vector2(room_pos.x + 256, room_pos.y + 128)
		elif neighbor_dir == c.DIRECTION.down:
			if tile_name == "RoomTile3":
				return Vector2(room_pos.x, room_pos.y + 256)
			elif tile_name == "RoomTile4":
				return Vector2(room_pos.x + 128, room_pos.y + 256)
	elif room_size == c.SIZE.big and neighbor.size == c.SIZE.long:
		if neighbor_dir == c.DIRECTION.left:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x - 256, room_pos.y)
			elif tile_name == "RoomTile3":
				return Vector2(room_pos.x - 256, room_pos.y + 128)
		elif neighbor_dir == c.DIRECTION.up:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x, room_pos.y - 128)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 128, room_pos.y - 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 128, room_pos.y - 128)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x, room_pos.y - 128)
		elif neighbor_dir == c.DIRECTION.right:
			if tile_name == "RoomTile2":
				return Vector2(room_pos.x + 256, room_pos.y)
			elif tile_name == "RoomTile4":
				return Vector2(room_pos.x + 256, room_pos.y + 128)
		elif neighbor_dir == c.DIRECTION.down:
			if tile_name == "RoomTile3" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x, room_pos.y + 256)
			elif tile_name == "RoomTile3" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 128, room_pos.y + 256)
			elif tile_name == "RoomTile4" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 128, room_pos.y + 256)
			elif tile_name == "RoomTile4" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x, room_pos.y + 256)
	elif room_size == c.SIZE.big and neighbor.size == c.SIZE.tall:
		if neighbor_dir == c.DIRECTION.left:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x - 128, room_pos.y)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 128, room_pos.y - 128)
			elif tile_name == "RoomTile3" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x - 128, room_pos.y + 128)
			elif tile_name == "RoomTile3" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 128, room_pos.y)
		elif neighbor_dir == c.DIRECTION.up:
			if tile_name == "RoomTile":
				return Vector2(room_pos.x, room_pos.y - 256)
			elif tile_name == "RoomTile2":
				return Vector2(room_pos.x + 128, room_pos.y - 256)
		elif neighbor_dir == c.DIRECTION.right:
			if tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 256, room_pos.y)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x + 256, room_pos.y - 128)
			elif tile_name == "RoomTile4" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 256, room_pos.y + 128)
			elif tile_name == "RoomTile4" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x + 256, room_pos.y)
		elif neighbor_dir == c.DIRECTION.down:
			if tile_name == "RoomTile3":
				return Vector2(room_pos.x, room_pos.y + 256)
			elif tile_name == "RoomTile4":
				return Vector2(room_pos.x + 128, room_pos.y + 256)
	elif room_size == c.SIZE.big and neighbor.size == c.SIZE.big:
		if neighbor_dir == c.DIRECTION.left:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 256, room_pos.y)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle4":
				return Vector2(room_pos.x - 256, room_pos.y - 128)
			elif tile_name == "RoomTile3" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 256, room_pos.y + 128)
			elif tile_name == "RoomTile3" and neighbor_tile_name == "RoomTitle4":
				return Vector2(room_pos.x - 256, room_pos.y)
		elif neighbor_dir == c.DIRECTION.up:
			if tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle3":
				return Vector2(room_pos.x, room_pos.y - 256)
			elif tile_name == "RoomTile" and neighbor_tile_name == "RoomTitle4":
				return Vector2(room_pos.x - 128, room_pos.y - 256)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle3":
				return Vector2(room_pos.x + 128, room_pos.y - 256)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle4":
				return Vector2(room_pos.x, room_pos.y - 256)
		elif neighbor_dir == c.DIRECTION.right:
			if tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 256, room_pos.y)
			elif tile_name == "RoomTile2" and neighbor_tile_name == "RoomTitle3":
				return Vector2(room_pos.x + 256, room_pos.y - 128)
			elif tile_name == "RoomTile4" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 256, room_pos.y + 128)
			elif tile_name == "RoomTile4" and neighbor_tile_name == "RoomTitle3":
				return Vector2(room_pos.x + 256, room_pos.y)
		elif neighbor_dir == c.DIRECTION.down:
			if tile_name == "RoomTile3" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x, room_pos.y + 256)
			elif tile_name == "RoomTile3" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x - 128, room_pos.y + 256)
			elif tile_name == "RoomTile4" and neighbor_tile_name == "RoomTitle":
				return Vector2(room_pos.x + 128, room_pos.y + 256)
			elif tile_name == "RoomTile4" and neighbor_tile_name == "RoomTitle2":
				return Vector2(room_pos.x, room_pos.y + 256)
	
	print("You slipped through a bug in the leaning hack of pisa, nice")


# Recursive function to redraw all rooms on a ship
func reposition_rooms(tile_id: String = "", room_pos: Vector2 = Vector2(256,256), completed: Array = []):
	if !tile_id:
		var bridge = get_node("/root/Game/Fleet/Ship/Rooms/Navigation2D/BridgeRoom")
		tile_id = bridge.get_node("Size/" + c.SIZES[bridge.size] + "/RoomTile").id
	if completed.has(tile_id):
		return
	var rooms = get_node("/root/Game/Fleet/Ship/Rooms/Navigation2D").get_children()
	for room in rooms:
		if room is YSort:
			continue
		for size in room.get_node("Size").get_children():
				if size.name == c.SIZES[room.size]:
					size.show()
				else:
					size.hide()
					continue
				for tile in size.get_children():
					if tile.id == tile_id:						
						completed.push_back(tile_id)
						room.position = room_pos
						if tile.neighbor_left:
							var neighbor_room_pos = get_neighbor_pos(tile.neighbor_left, c.DIRECTION.left, tile.name, room.size, room_pos, room.id)
							reposition_rooms(tile.neighbor_left, neighbor_room_pos, completed)
						if tile.neighbor_top:
							var neighbor_room_pos = get_neighbor_pos(tile.neighbor_top, c.DIRECTION.up, tile.name, room.size, room_pos, room.id)
							reposition_rooms(tile.neighbor_top, neighbor_room_pos, completed)
						if tile.neighbor_right:
							var neighbor_room_pos = get_neighbor_pos(tile.neighbor_right, c.DIRECTION.right, tile.name, room.size, room_pos, room.id)
							reposition_rooms(tile.neighbor_right, neighbor_room_pos, completed)
						if tile.neighbor_bottom:
							var neighbor_room_pos = get_neighbor_pos(tile.neighbor_bottom, c.DIRECTION.down, tile.name, room.size, room_pos, room.id)
							reposition_rooms(tile.neighbor_bottom, neighbor_room_pos, completed)


func refresh_walls():
	var rooms = get_node("/root/Game/Fleet/Ship/Rooms/Navigation2D").get_children()
	for room in rooms:
		if room is YSort:
			continue
		for size in room.get_node("Size").get_children():
			if size.name == c.SIZES[room.size]:
				size.show()
				for tile in size.get_children():
					for wall in tile.get_node("Walls").get_children():
						wall.display()
			else:
				size.hide()

# Scans spaces adjascent to provided room to add any missing neighbors
func seek_missing_neighbors(r: Node2D):
	var rooms = get_node("/root/Game/Fleet/Ship/Rooms/Navigation2D").get_children()
	for room in rooms:
		if room.name == "YSort" or room.id == r.id:
			continue
		for tile in room.get_node("Size/" + c.SIZES[room.size]).get_children():
			for rt in r.get_node("Size/" + c.SIZES[r.size]).get_children():
				var seeking = Vector2(r.position.x + rt.position.x, r.position.y + rt.position.y)
				var scanning = Vector2(room.position.x + tile.position.x, room.position.y + tile.position.y)
				if !rt.neighbor_left and !rt.is_interior_left and Vector2(seeking.x - 128, seeking.y) == scanning:
					rt.neighbor_left = tile.id
					tile.neighbor_right = rt.id
				if !rt.neighbor_top and !rt.is_interior_top and Vector2(seeking.x, seeking.y - 128) == scanning:
					rt.neighbor_top = tile.id
					tile.neighbor_bottom = rt.id
				if !rt.neighbor_right and !rt.is_interior_right and Vector2(seeking.x + 128, seeking.y) == scanning:
					rt.neighbor_right = tile.id
					tile.neighbor_left = rt.id
				if !rt.neighbor_bottom and !rt.is_interior_bottom and Vector2(seeking.x, seeking.y + 128) == scanning:
					rt.neighbor_bottom = tile.id
					tile.neighbor_top = rt.id


func set_tile_neighbor(tile_id: String, neighbor_dir: int, neighbor_id: String):
	var rooms = get_node("/root/Game/Fleet/Ship/Rooms/Navigation2D").get_children()
	for room in rooms:
		if room is YSort:
			continue
		for size in room.get_node("Size").get_children():
			if size.name == c.SIZES[room.size]:
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
