extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("DISOLVE")
	await $AnimationPlayer.animation_finished
	var status = get_tree().change_scene_to_file(target)
	Global.restore_lives()
	if (not status == OK):
		var no_more_levels_scene = "res://scenes/no_more_level_scene.tscn"
		get_tree().change_scene_to_file(no_more_levels_scene)
	$AnimationPlayer.play_backwards("DISOLVE")
