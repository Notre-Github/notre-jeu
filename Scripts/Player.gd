extends CharacterBody2D

@export var health = 6
@export var healing_delay = 3
var healing

@export var speed = 400
@export var offset = 12
@export var friction = 0.25
@export var acceleration = 0.25

@export var dash_force = 4
@export var dash_delay = 1
@export var dash_time = 0.1
var dash_reload = 0
var dash_duration = 0

func _ready():
	$HealthBar.max_value = health

func get_input():
	if Input.is_action_just_pressed("knife"):
		get_node("Knife/AnimationPlayer").play("Knife_Slash")
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
	if health <= 0:
		queue_free()
	$HealthBar.value = health

	if health != $HealthBar.max_value:
		healing -= _delta
		if healing <= 0:
			health += 1
			healing = healing_delay

	var direction = get_input();
	dash_reload -= _delta
	if dash_reload > 0:
		$PlayerSprite.material.blend_mode = 3
	else:
		$PlayerSprite.material.blend_mode = 0

	if Input.is_action_just_pressed("dash") && dash_reload <= 0:
		dash_duration = dash_time

	if direction.length() > 0 && dash_duration > 0:
		velocity = lerp(velocity, direction.normalized() * speed * dash_force, acceleration)
		dash_reload = dash_delay
		dash_duration -= _delta
	elif direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)

func _process(_delta):
	move_and_slide()
	$Shotgun/WeaponSprite.position = $Shotgun/WeaponSprite.transform.x * offset;
	$Shotgun.rotation = lerp_angle($Shotgun.rotation, $Shotgun.rotation + $Shotgun.get_angle_to(get_global_mouse_position()), 0.1)
	if abs($Shotgun.global_rotation_degrees) > 90:
		$Shotgun/WeaponSprite.flip_v = true
	else:
		$Shotgun/WeaponSprite.flip_v = false
	
	$Knife/KnifeSprite.position = $Knife/KnifeSprite.transform.x * offset;
	$Knife.rotation = lerp_angle($Knife.rotation, $Knife.rotation + $Knife.get_angle_to(get_global_mouse_position()), 0.1)

