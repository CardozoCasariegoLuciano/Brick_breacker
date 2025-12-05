extends Node2D
@onready var level_ui: Control = $Level_UI
@onready var bricks_container: Node2D = $Bricks
@onready var initial_position: Marker2D = $InitialPosition
@onready var playables: Node2D = $playables
@onready var powers_container: Node2D = $PowersContainer

@export var level:int = 1

func _ready() -> void:
	playables.create_playables(initial_position)
	Global.on_level_change.emit(level)
	level_ui.on_change_current_bricks.emit(bricks_container.destructibles_bricks)

	if is_mobile():
		var hud = preload("res://scenes/mobile_controller.tscn")
		var hud_instance = hud.instantiate()
		add_child(hud_instance)

func _on_bricks_destroy(cuantity: int) -> void:
	level_ui.on_change_current_bricks.emit(cuantity)
	if cuantity == 0:
		SceneTransition.change_scene("res://scenes/level_" + str(level + 1) +".tscn")

func desconect_signals():
	if(bricks_container.is_connected("on_destroy_brick", _on_bricks_destroy)):
		bricks_container.disconnect("on_destroy_brick", _on_bricks_destroy)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		var pause_modal = preload("res://scenes/pause_modal.tscn").instantiate()
		add_child(pause_modal)
		get_tree().paused = true

func is_mobile():
	if JavaScriptBridge:
		var result = JavaScriptBridge.eval("""
			/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
		""", true)
		return result
	return false


func _on_live_lost() -> void:
	print("Playables: ",playables.get_child_count())
	if playables.get_child_count() <= 2:
		
		Global.lost_live()
		remove_floating_powers()
		playables.create_playables(initial_position)
		

func add_power_in_containier(power):
	powers_container.add_child(power)

func remove_floating_powers():
	print(powers_container.get_children())
	for node in powers_container.get_children():
		powers_container.call_deferred("remove_child",node)

#TODO: Agregar que caigan poderes de los bloques
	#Crear los sprites de los poderes
	#Agregar mas poderes y su funcinalidad
	#Actualizar los niveles
	#Agregar que los bloques tengan una pequeña chance de ser x2, x3 o x4


#TODO: Agregar mas niveles
#TODO: Agregar multijugador local (una en la parte de abajo y otro en la de arriba, cada uno con su pelota
#		pero con los mismos bloques)


#Agregados bloques con mucha vida
#Fix disparar con el celu
