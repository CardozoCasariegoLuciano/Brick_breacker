extends Control

func get_current_level() -> String:
	var nivel = Global.current_lvl
	Global.restore_lives()
	return "res://scenes/level_" + str(nivel) +".tscn"

func _on_button_button_up() -> void:
	get_tree().change_scene_to_file(get_current_level())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		_on_button_button_up()
