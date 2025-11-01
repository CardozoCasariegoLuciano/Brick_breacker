extends Node
signal on_level_change(level: int)

var current_lvl: int
var current_lives

func _ready() -> void:
	on_level_change.connect(save_last_lvl)

func save_last_lvl(lvl):
	current_lvl = lvl
