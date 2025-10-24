extends Control
signal on_change_current_bricks(cant:int)

@onready var level: Label = $HBoxContainer/level
@onready var bricks: Label = $HBoxContainer2/bricks

func _ready() -> void:
	Global.on_level_change.connect(update_level)

func _on_change_current_bricks(cant: int) -> void:
	bricks.text = str(cant)

func update_level(lvl):
	level.text = str(lvl)
