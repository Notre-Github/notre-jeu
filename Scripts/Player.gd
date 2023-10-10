extends CharacterBody2D

var input_direction = Vector2.ZERO

@export var health = 6
@export var healing_delay = 3
var healing

@export var speed = 400
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
	input_direction = Vector2.ZERO
	if Input.is_action_pressed('move_right'):
		input_direction.x += 1
	if Input.is_action_pressed('move_left'):
		input_direction.x -= 1
	if Input.is_action_pressed('move_up'):
		input_direction.y -= 1
	if Input.is_action_pressed('move_down'):
		input_direction.y += 1
	if input_direction.length() > 0:
		velocity = lerp(velocity, input_direction.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)
	if Input.is_action_just_pressed("dash") && dash_reload <= 0:
		dash_duration = dash_time
		$DashingParticles/StartDashParticles.emitting = true
		$DashingParticles.emitting = true
	return input_direction


func footsteps_particles():
	if input_direction.length() > 0:
		$RunningParticles.emitting = true
	else:
		$RunningParticles.emitting = false


func character_health():
	if health <= 0:
		queue_free()
	$HealthBar.value = health
	if health != $HealthBar.max_value:
		healing -= get_physics_process_delta_time()
		if healing <= 0:
			health += 1
			healing = healing_delay


func dash(): 
	dash_reload -= get_physics_process_delta_time()
	if dash_reload > 0:
		$PlayerSprite.material.blend_mode = 3
	else:
		$PlayerSprite.material.blend_mode = 0
	if input_direction.length() > 0 && dash_duration > 0:
		$DashingParticles.emitting = true
		velocity = lerp(velocity, input_direction.normalized() * speed * dash_force, acceleration)
		dash_reload = dash_delay
		dash_duration -= get_physics_process_delta_time()

func _physics_process(_delta):
	get_input()
	dash()
	character_health()
	footsteps_particles()

func _process(_delta):
	move_and_slide()
