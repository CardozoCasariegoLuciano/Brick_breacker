extends CanvasLayer


func _on_close_button() -> void:
	get_tree().paused = false
	queue_free()
