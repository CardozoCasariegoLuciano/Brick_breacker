extends CanvasLayer


func _on_change_lang_to_EN() -> void:
	TranslationServer.set_locale("en")

func _on_change_lang_to_ES() -> void:
	TranslationServer.set_locale("es")
	

func _on_close_button() -> void:
	get_tree().paused = false
	queue_free()
