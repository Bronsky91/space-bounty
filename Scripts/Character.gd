extends Node2D

func _ready():
	$AnimationPlayer.play("IdleDown")

func _process(delta):
	pass

func _on_AnimationPlayer_animation_started(anim_name):
	if 'Down' in anim_name:
		move_child($HairB, 0)
	else:
		move_child($HairB, 7)
