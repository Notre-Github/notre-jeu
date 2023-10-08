extends CharacterBody2D

@export var speed = 400
@export var offset = 12
@export var friction = 0.25
@export var acceleration = 0.25
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	if Input.is_action_pressed("confirm"):
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
	var direction = get_input();
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)

func _process(_delta):
	move_and_slide()
	$Shotgun/ShotgunSprite.position = $Shotgun/ShotgunSprite.transform.x * offset;
	$Shotgun.rotation = lerp_angle($Shotgun.rotation, $Shotgun.rotation + $Shotgun.get_angle_to(get_global_mouse_position()), 0.1)
	if abs($Shotgun.global_rotation_degrees) > 90:
		$Shotgun/ShotgunSprite.flip_v = true
	else:
		$Shotgun/ShotgunSprite.flip_v = false
	
	$Knife/KnifeSprite.position = $Knife/KnifeSprite.transform.x * offset;
	$Knife.rotation = lerp_angle($Knife.rotation, $Knife.rotation + $Knife.get_angle_to(get_global_mouse_position()), 0.1)

