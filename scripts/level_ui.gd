extends Control
@warning_ignore("UNUSED_SIGNAL")
signal on_change_current_bricks(cant:int)

@onready var level: Label = $HBoxContainer/level
@onready var bricks: Label = $TextureRect/bricks
@onready var hp_container: Node2D = $HP_Container

const HP_texture = "res://assets/playables/blade.png"

func _ready() -> void:
	Global.on_level_change.connect(update_level)
	Global.on_lives_change.connect(update_HP)
	update_HP(Global.current_lives)

func _on_change_current_bricks(cant: int) -> void:
	bricks.text = str(cant)

func update_level(lvl):
	level.text = str(lvl)

func update_HP(HP):
	clear_HP_textures()
	for a in HP:
		var texture_HP = TextureRect.new()
		texture_HP.texture = preload(HP_texture)
		texture_HP.scale = Vector2(0.3,0.3)
		texture_HP.position.x = hp_container.get_child_count() * -80 
		
		hp_container.add_child(texture_HP)
	
func clear_HP_textures():
	for node in hp_container.get_children():
		hp_container.remove_child(node)


func _on_button_down() -> void:
	get_tree().paused = true
	var panel = preload("res://scenes/options_menu.tscn").instantiate()
	add_child(panel)
