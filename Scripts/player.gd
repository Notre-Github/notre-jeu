extends CharacterBody2D

@export var speed = 400
@export var offset = 50
@export var friction = 0.25
@export var acceleration = 0.25
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	move_and_slide()
	$Weapon.position = $Weapon.transform.x * offset;
	$Weapon.look_at(get_global_mouse_position())

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

func _physics_process(delta):
	var direction = get_input();
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
