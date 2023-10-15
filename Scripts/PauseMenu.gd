extends Control

@onready var is_paused:bool = get_tree().paused


func _input(event: InputEvent) -> void: # Show the pause menu when 'Escape' is pressed
	if event.is_action_pressed("ui_cancel") && visible == false:
		show()
		get_tree().paused = !is_paused
	elif event.is_action_pressed("ui_cancel") && visible == true:
		hide()
		get_tree().paused = is_paused

func _on_resume_button_pressed() -> void: # Unpause when resume is clicked on
	get_tree().paused = is_paused
	hide()

func _on_settings_button_pressed() -> void: # Show the settings panel and hide the main pause menu when clicked on
	$PausePanel/VerticalList.visible = false
	$PausePanel/Settings.visible = true

func _on_window_mode_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	elif index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_v_sync_toggle_toggled(button_pressed: bool) -> void:
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_back_button_pressed() -> void:
	$PausePanel/VerticalList.visible = true
	$PausePanel/Settings.visible = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()



