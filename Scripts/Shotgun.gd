extends Node2D

@onready var bullet_scene = preload("res://Scenes/bullet.tscn")
@export var shotgun_rate = 0.5
var shotgun_reload = 0

func _process(_delta):
	shotgun_reload -= _delta
	if Input.is_action_just_pressed("fire") && shotgun_reload < 0:
		shotgun_reload = shotgun_rate;
		var bullet = bullet_scene.instantiate()
		get_node("/root/Main").add_child(bullet)
		bullet.global_transform = $WeaponSprite/WeaponCanon.global_transform
		bullet.scale = Vector2(1, 1)
