extends Node2D

var speed = 50
var destination: Vector2
var path: PoolVector2Array
var nav: Navigation2D
var last_direction: Vector2 = Vector2.DOWN
var stopped: bool = false
var current_room: Node2D
var moving_rooms: bool = false
var destination_room: Node2D
var current_room_pos: Position2D
var avail_to_chat: bool = false

var animation_directions = {
	Vector2.RIGHT: "Right",
	Vector2.RIGHT + Vector2.DOWN: "Down",
	Vector2.DOWN: "Down",
	Vector2.LEFT + Vector2.DOWN: "Down",
	Vector2.LEFT: "Left",
	Vector2.LEFT + Vector2.UP: "Up",
	Vector2.UP: "Up",
	Vector2.RIGHT + Vector2.UP: "Up",
	Vector2(0, 0): "Down"
}

signal direction_change

func _ready():
	$AnimationPlayer.play("IdleDown")
	connect("direction_change", self, '_on_direction_change')

func _process(delta):
	# Calculate the movement distance for this frame
	var distance_to_walk = speed * delta
	# Move the character along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		stopped = false
		emit_signal("direction_change", position.direction_to(path[0]).round ())
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The character does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
			last_direction = position.direction_to(path[0]).round ()
		else:
			# The character get to the next point
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
	
	if path.size() == 0 or speed == 0 and not stopped:
		play_stopped_animation()
		stopped = true
		if moving_rooms and destination_room == current_room:
			moving_rooms = false
		
func _on_direction_change(new_direction):
	if new_direction != last_direction:
		var animation_direction = animation_directions[new_direction]
		$AnimationPlayer.play("Walk"+animation_direction)
	if stopped:
		play_stopped_animation()

func play_stopped_animation():
	var animation_direction = animation_directions[last_direction]
	$AnimationPlayer.play("Idle"+animation_direction)

func _on_AnimationPlayer_animation_started(anim_name):
	if 'Down' in anim_name:
		move_child($HairB, 0)
	else:
		move_child($HairB, 7)
	
func get_all_rooms():
	var rooms = nav.get_children()
	for room in rooms:
		if room is YSort:
			rooms.erase(room)
	return rooms
	
func get_random_room():
	randomize()
	var rand_room = randi() % get_all_rooms().size()
	return get_all_rooms()[rand_room]
	
func get_random_room_position(room: Node2D):
	var positions = room.available_positions
	if positions.size() <= 1: # No available in positions to move to in this room
		return
	randomize()
	var rand_pos = randi() % positions.size()
	return positions[rand_pos]

func move_rooms():
	if get_all_rooms().size() > 1:
		moving_rooms = true
		destination_room = get_random_room()
		move_room_position(destination_room)

func move_position_in_current_room():
	if not moving_rooms:
		move_room_position(current_room)

func move_room_position(room):
	var room_pos = get_random_room_position(room)
	if not room_pos:
		# No available positions in the room, character moving rooms
		return move_rooms()
	current_room.free_position(current_room_pos)
	current_room_pos = room.take_position(room_pos)
	path = nav.get_simple_path(position, room_pos.global_position)
	
func _on_ChangeRoomTimer_timeout():
	move_rooms()
	
func _on_ChangePosTimer_timeout():
	move_position_in_current_room()

func _on_Area2D_area_entered(area):
	var container = area.get_node("../..")
	if container.name.ends_with("Room"):
		current_room = container
	if 'Character' in area.get_parent().name and avail_to_chat and area.get_parent().avail_to_chat:
		speed = 0
		avail_to_chat = false
		$ChatCooldown.stop()
		$ChatDuration.start()
		$ChatBubbles/ChatSweat.show()

func _on_ChatCooldown_timeout():
	avail_to_chat = true

func _on_ChatDuration_timeout():
	speed = 50
	$ChatCooldown.start()
	$ChatBubbles/ChatSweat.hide()
	
