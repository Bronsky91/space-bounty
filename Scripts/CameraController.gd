extends Camera2D

onready var helm = get_node("/root/Game/Fleet/Ship/Rooms/Helm")
var _previousPosition: Vector2 = Vector2(0, 0);
var _moveCamera: bool = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	position = helm.position

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		get_tree().set_input_as_handled()
		if event.is_pressed():
			_previousPosition = event.position
			_moveCamera = true
		else:
			_moveCamera = false
	elif event is InputEventMouseMotion and _moveCamera:
		get_tree().set_input_as_handled()
		position += (_previousPosition - event.position)
		_previousPosition = event.position
