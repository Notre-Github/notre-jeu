extends RigidBody2D

var health = 2

func _ready():
	add_to_group("Objects")

func _crate_health():
	if health <= 0:
		queue_free()

func _physics_process(_delta: float) -> void:
	_crate_health()
