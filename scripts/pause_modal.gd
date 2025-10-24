extends CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		await get_tree().create_timer(0).timeout
		get_tree().paused = false
		queue_free()
