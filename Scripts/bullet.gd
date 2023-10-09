extends Area2D

func _process(delta):
	position += (transform.x * 1000) * delta 

func _on_body_entered(body):
	if body == get_node("/root/Main/Enemy"):
		get_node("/root/Main/Enemy").health -= 1

	if body == get_node("/root/Main/Player"):
		get_node("/root/Main/Player").health -= 1
		get_node("/root/Main/Player").healing = get_node("/root/Main/Player").healing_delay
	queue_free()
