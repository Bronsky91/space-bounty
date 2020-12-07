extends Node2D

var speed = 50
var destination: Vector2
var path: PoolVector2Array
var nav: Navigation2D
var last_direction: Vector2 = Vector2.DOWN
var stopped: bool = false

var animation_directions = {
	Vector2.RIGHT: "Right",
	Vector2.RIGHT + Vector2.DOWN: "Down",
	Vector2.DOWN: "Down",
	Vector2.LEFT + Vector2.DOWN: "Down",
	Vector2.LEFT: "Left",
	Vector2.LEFT + Vector2.UP: "Up",
	Vector2.UP: "Up",
	Vector2.RIGHT + Vector2.UP: "Up",
}

signal direction_change
signal stop_change

func _ready():
	$AnimationPlayer.play("IdleDown")
	connect("direction_change", self, '_on_direction_change')
	connect("stop_change", self, '_on_stop_change')

func _process(delta):
	# Calculate the movement distance for this frame
	var distance_to_walk = speed * delta
	# Move the character along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		stopped = false
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The character does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
			emit_signal("direction_change", position.direction_to(path[0]).round ())
			last_direction = position.direction_to(path[0]).round ()
		else:
			# The character get to the next point
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
	
	if path.size() == 0 and not stopped:
		play_stopped_animation()
		stopped = true
		
func _on_direction_change(new_direction):
	if new_direction != last_direction:
		var animation_direction = animation_directions[new_direction]
		$AnimationPlayer.play("Walk"+animation_direction)
	if stopped:
		play_stopped_animation()

func play_stopped_animation():
	var animation_direction = animation_directions[last_direction]
	$AnimationPlayer.play("Idle"+animation_direction)
			
func _input(event):
	if event.is_action_released("left_click"):
		destination = get_global_mouse_position()
		path = nav.get_simple_path(position, destination)

func _on_AnimationPlayer_animation_started(anim_name):
	if 'Down' in anim_name:
		move_child($HairB, 0)
	else:
		move_child($HairB, 7)
