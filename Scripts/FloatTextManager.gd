extends Node2D

var FT = preload("res://Scenes/FloatText.tscn")

export var travel: Vector2 = Vector2(0, -80)
export var duration: int = 2
export var spread: float = PI/2

func float_text(value, is_positive: bool = true) -> void:
	var ft = FT.instance()
	add_child(ft)
	if is_positive:
		ft.float_text("+" + str(value), c.SB_GREEN, travel, duration, spread)
	else:
		ft.float_text("-" + str(value), c.SB_RED, travel, duration, spread)
