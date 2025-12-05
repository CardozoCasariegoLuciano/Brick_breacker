extends Area2D
signal on_live_lost

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		if Global.current_lives == 0:
			get_parent().desconect_signals()
			await get_tree().create_timer(0.2).timeout
			get_tree().call_deferred("change_scene_to_file", "res://scenes/defeat_modal.tscn")
		else:
			on_live_lost.emit()
			audio_stream_player.play()
