extends Control

func _fps_counter():
	var fps = Engine.get_frames_per_second()
	$VBoxContainer/FPSCounter.text = "FPS: "+str(fps)

func _vsync_status():
	var vsync = DisplayServer.window_get_vsync_mode()
	$VBoxContainer/VSyncStatus.text = "VSync: "+str(vsync)

func _get_player_position():
	var player_position = get_node("/root/Main/Player").global_position
	$VBoxContainer/PlayerPosition.text = "Player position: "+str(player_position)

func _number_of_enemies():
	var entities = get_tree().get_nodes_in_group("Enemies").size()
	$VBoxContainer/Entities.text = "Amount of entities: "+str(entities)

func _process(_delta: float):
	_fps_counter()
	_vsync_status()
	_get_player_position()
	_number_of_enemies()
