extends Area2D

var time = 0.15

func _process(delta):
	position += (transform.x * 1000) * delta
	time -= delta
	if time <= 0:
		queue_free()

func _on_body_entered(body):
	if body.get_name().begins_with("Enemy"):
		body.health -= 1

	if body == get_node("/root/Main/Player"):
		get_node("/root/Main/Player").health -= 1
		get_node("/root/Main/Player").healing = get_node("/root/Main/Player").healing_delay * 3
	queue_free()
