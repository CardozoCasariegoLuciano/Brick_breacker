extends Node2D
@onready var level_ui: Control = $Level_UI
@onready var bricks_container: Node2D = $Bricks

@export var level:int = 1

func _ready() -> void:
	Global.on_level_change.emit(level)
	level_ui.on_change_current_bricks.emit(bricks_container.destructibles_bricks)
	
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

 #Armar la pag de ichio
# Subirlo a git

#MVP: Hacer los sprites de los botones y el resto del HUD
#MVP: Agregar que caigan poderes de los bloques
#MVP: Agregar un guardado de partida para no arrancar del inico
#MVP: Agregar un puntaje
#MVP: Agregar bloques que requieran mas de un golpe
#MVP: Agregar un selector de niveles
#MVP: Agregar mas niveles
#MVP: Agregar multijugador local (una en la parte de abajo y otro en la de arriba, cada uno con su pelota
#		pero con los mismos bloques)
#MVP: Mejorar los visuales
#MVP: Mejorar el Sonido
#MVP: Agregar una pantalla de inicio
#MVP: Agregar una pantalla de opciones
