extends Area2D

func _process(delta):
	position += (transform.x * 1000) * delta

func _on_body_entered(body):
	if body.get_name().begins_with("Enemy"):
		body.health -= 5

	if body == get_node("/root/Main/Player"):
		body.health -= 1
		body.healing = body.healing_delay * 3
	queue_free()
