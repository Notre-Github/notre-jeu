extends Area2D

func _process(delta):
	position += (transform.x * 1000) * delta

func _on_body_entered(body):
	if body in get_tree().get_nodes_in_group("Enemies"):
		body.health -= 5
	
	if body in get_tree().get_nodes_in_group("Objects"):
		body.health -= 1

	if body == get_tree().get_first_node_in_group("Player"):
		body.health -= 1
		body.healing = body.healing_delay * 3
	queue_free()
