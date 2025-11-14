extends Node2D
@onready var level_ui: Control = $Level_UI
@onready var bricks_container: Node2D = $Bricks
@onready var initial_position: Marker2D = $InitialPosition
@onready var playables: Node2D = $playables

@export var level:int = 1

const BALL = preload("res://scenes/ball.tscn")
const BLADE = preload("res://scenes/blade.tscn")

func _ready() -> void:
	create_playables()
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
	create_playables()

func create_playables():
	remove_playables()

	var ball_instance = BALL.instantiate() as Ball
	var blade_instance = BLADE.instantiate() as Blade

	ball_instance.init_ball(blade_instance)

	var marker_position = initial_position.position
	blade_instance.position = marker_position
	ball_instance.position = Vector2(marker_position.x,marker_position.y - 50)
	playables.call_deferred("add_child",ball_instance)
	playables.call_deferred("add_child",blade_instance)

func remove_playables():
	for node in playables.get_children():
		playables.remove_child(node)

#TODO: Crear los sprites de:
	#Modal de opciones
	#La X para cerrar el modal
	#El icono del engranaje para la UI




#TODO: Agregar que caigan poderes de los bloques
#TODO: Agregar un puntaje
#		EJ, mas puntos con combos de rebotes
#		Guardar los puntajes de cada jugadore
#TODO: Agregar bloques que requieran mas de un golpe
#TODO: Agregar mas niveles
#TODO: Agregar multijugador local (una en la parte de abajo y otro en la de arriba, cada uno con su pelota
#		pero con los mismos bloques)



#Para el proximo update:
#- Agregado menu de inicio y de opciones
#- Mejorado el visual de los niveles
#- Ajuste a los niveles deacuerdo a sus dificultades
#- Ajustados los bordes de la paleta para que sea mas probable que rebote para arriba
#- Mas de una vida para cada nivel
#- La pelota no se dispara de una
#- Multi idioma
