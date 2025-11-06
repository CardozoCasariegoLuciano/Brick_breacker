extends Control


func _on_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_change_lang_to_EN() -> void:
	TranslationServer.set_locale("en")

func _on_change_lang_to_ES() -> void:
	TranslationServer.set_locale("es")
