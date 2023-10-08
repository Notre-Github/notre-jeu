extends CharacterBody2D

@export var speed = 400
@export var offset = 12
@export var friction = 0.25
@export var acceleration = 0.25
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(_delta):
	move_and_slide()
	$Weapon/WeaponSprite.position = $Weapon/WeaponSprite.transform.x * offset;
	$Weapon.rotation = lerp_angle($Weapon.rotation, $Weapon.rotation + $Weapon.get_angle_to(get_global_mouse_position()), 0.1)
	if abs($Weapon.global_rotation_degrees) > 90:
		$Weapon/WeaponSprite.flip_v = true
	else:
		$Weapon/WeaponSprite.flip_v = false
	print($Weapon.global_rotation_degrees)

func get_input():
	var direction = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	return direction

func _physics_process(_delta):
	var direction = get_input();
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
