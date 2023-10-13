extends Node2D

var offset = 11
@onready var bullet_scene = preload("res://Scenes/Bullet.tscn")
@export var shotgun_rate = 0.25
var shotgun_reload = 0

func shotgun_follow_mouse():
	$WeaponSprite.position = $WeaponSprite.transform.x * offset;
	rotation = lerp_angle(rotation, rotation + get_angle_to(get_global_mouse_position()), 0.1)
	if abs(global_rotation_degrees) > 90:
		$WeaponSprite.flip_v = true
	else:
		$WeaponSprite.flip_v = false

func _process(_delta):
	shotgun_follow_mouse()
	shotgun_reload -= _delta
	if Input.is_action_just_pressed("fire") && shotgun_reload < 0:
		shotgun_reload = shotgun_rate;
		var bullet = bullet_scene.instantiate()
		get_node("/root/Main").add_child(bullet)
		bullet.global_transform = $WeaponSprite/WeaponCanon.global_transform
		bullet.scale = Vector2(1, 1)
