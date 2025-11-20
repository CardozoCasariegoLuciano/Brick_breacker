extends Control


func _on_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_options_button() -> void:
	var panel = preload("res://scenes/options_menu.tscn").instantiate()
	add_child(panel)
