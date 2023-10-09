extends Node2D

var offset = 12

func _process(_delta):
	if Input.is_action_just_pressed("knife"):
		get_node("AnimationPlayer").play("Knife_Slash")
	$KnifeSprite.position = $KnifeSprite.transform.x * offset;
	rotation = lerp_angle(rotation, rotation + get_angle_to(get_global_mouse_position()), 0.1)
