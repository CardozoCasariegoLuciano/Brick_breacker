extends Control

@export var button_redirection: PackedScene

func _on_button_up() -> void:
	get_tree().change_scene_to_packed(button_redirection)
