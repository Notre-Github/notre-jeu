extends CharacterBody2D

@export var input_direction = Vector2.ZERO

@export var health = 60
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

@onready var shotgun_scene = preload("res://Scenes/Shotgun.tscn").instantiate()
@onready var pistol_scene = preload("res://Scenes/Pistol.tscn").instantiate()


func _ready() -> void:
	add_to_group("Player")
	$HealthBar.max_value = health

func swap_weapons(old_scene, new_scene) -> void:
	remove_child(old_scene)
	add_child(new_scene)

func get_input() -> Vector2:
	if Input.is_action_just_pressed('w1'):
		swap_weapons(get_node("Weapon"), shotgun_scene)
	if Input.is_action_just_pressed('w2'):
		swap_weapons(get_node("Weapon"), pistol_scene)
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

func footsteps_particles() -> void:
	if input_direction.length() > 0:
		$RunningParticles.emitting = true
	else:
		$RunningParticles.emitting = false

func character_health() -> void:
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

func leaning_direction() -> void:
	$PlayerSprite.position = $PlayerSprite.transform.x; # Player's body
	$PlayerSprite/LeftHand.look_at($Weapon/WeaponSprite.global_position) # Player's left arm
	$PlayerSprite/RightHand.look_at($Weapon/WeaponSprite.global_position) # Player's right Arm

func _pushing_direction() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var push_force = speed
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_force(-collision.get_normal() * push_force)

func _physics_process(_delta):
	get_input()
	dash()
	character_health()
	footsteps_particles()

func _process(_delta):
	move_and_slide()
	leaning_direction()
	_pushing_direction()
