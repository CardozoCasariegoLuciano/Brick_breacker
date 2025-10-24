extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		get_parent().desconect_signals()
		await get_tree().create_timer(0.2).timeout
		get_tree().call_deferred("change_scene_to_file", "res://scenes/defeat_modal.tscn")
