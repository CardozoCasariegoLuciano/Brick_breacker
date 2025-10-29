extends Node2D
@onready var level_ui: Control = $Level_UI
@onready var bricks_container: Node2D = $Bricks

@export var level:int = 1

func _ready() -> void:
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
		var a = preload("res://scenes/pause_modal.tscn").instantiate()
		add_child(a)
		get_tree().paused = true

func is_mobile():
	if JavaScriptBridge:
		var result = JavaScriptBridge.eval("""
			/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
		""", true)
		return result
	return false
	
#Mejorar los visuales
#Mejorar el Sonido
#Hacer los sprites de los botones y el resto del HUD
#Actualizar el ichio



#TODO: Agregar un selector de niveles
#TODO: Agregar que caigan poderes de los bloques
#TODO: Agregar un guardado de niveles para no arrancar de el nivel 1
#TODO: Agregar mas vidas para no arrancar el nivel desde 0
#TODO: Agregar un puntaje
#		EJ, mas puntos con combos de rebotes
#		Guardar los puntajes de cada jugadore
#TODO: Agregar bloques que requieran mas de un golpe
#TODO: Agregar mas niveles
#TODO: Agregar multijugador local (una en la parte de abajo y otro en la de arriba, cada uno con su pelota
#		pero con los mismos bloques)
#TODO: Agregar una pantalla de opciones para modificar el sonido y los controles
#TODO: Hacerlo multiidioma
