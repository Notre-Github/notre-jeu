extends Area2D

func _process(delta):
	position += (transform.x * 1000) * delta 

func _on_body_entered(body):
	queue_free()
