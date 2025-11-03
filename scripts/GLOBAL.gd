extends Node
signal on_level_change(level: int)
signal on_lives_change(HP: int)

const INITIAL_LIVES = 2

var current_lvl: int

var _lives: int
var current_lives: int:
	set(value):
		_lives = value
		on_lives_change.emit(_lives)
	get():
		return _lives


func _ready() -> void:
	on_level_change.connect(save_last_lvl)
	restore_lives()
	
func restore_lives():
	current_lives = INITIAL_LIVES

func lost_live():
	current_lives = current_lives - 1
	
func save_last_lvl(lvl):
	current_lvl = lvl
