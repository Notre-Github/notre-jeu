extends CharacterBody2D

var health = 20;

@export var speed = 200
@export var friction = 0.25
@export var acceleration = 0.25

@onready var bullet_scene = preload("res://Scenes/Bullet.tscn")
@export var shotgun_rate = 1.5
var shotgun_reload = 2

func _ready():
	$HealthBar.max_value = health

func _process(delta):
	move_and_slide()

	$EnemyWeapon/EnemyWeaponSprite.position = $EnemyWeapon/EnemyWeaponSprite.transform.x * 12;
	$EnemyWeapon.rotation = lerp_angle($EnemyWeapon.rotation, $EnemyWeapon.rotation + $EnemyWeapon.get_angle_to(get_node("/root/Main/Player").global_position), 0.1)
	if abs($EnemyWeapon.global_rotation_degrees) > 90:
		$EnemyWeapon/EnemyWeaponSprite.flip_v = true
	else:
		$EnemyWeapon/EnemyWeaponSprite.flip_v = false

	shotgun_reload -= delta
	if shotgun_reload < 0:
		shotgun_reload = shotgun_rate;
		var bullet = bullet_scene.instantiate()
		get_node("/root/Main").add_child(bullet)
		bullet.global_transform = $EnemyWeapon/EnemyWeaponSprite/EnemyWeaponBarrel.global_transform
		bullet.scale = Vector2(1, 1)

func _physics_process(_delta):
	if health <= 0:
		queue_free()
	$HealthBar.value = health

	var direction = Vector2(cos(get_angle_to(get_node("/root/Main/Player").global_position)), sin(get_angle_to(get_node("/root/Main/Player").global_position)))
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
