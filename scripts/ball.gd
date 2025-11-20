extends RigidBody2D
class_name Ball

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var blade_sound_timer: Timer = $BladeSoundTImer

const INITIAL_SPEED = 400
var current_speed = INITIAL_SPEED
var velocity: Vector2 = Vector2(0, -1) * INITIAL_SPEED

var static_mode = {
	"active": true,
	"target": null
}
var can_emit_blade_sound = true

func init_ball(blade: Blade):
	static_mode["target"] = blade

func _physics_process(delta: float) -> void:
	if static_mode["active"]:
		global_position.x = static_mode["target"].global_position.x
	else:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal()).normalized() * current_speed
			handle_horizontal_bounce()
		
			if collision.get_collider() is Blade:
				handle_blade_collition(collision)
			elif collision.get_collider() is Brick:
				handle_brick_collition(collision)
			else:
				emit_sound(preload("res://assets/sounds/ball_hit1.ogg"))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		static_mode["active"] = false

func handle_blade_collition(collition: KinematicCollision2D):
	var blade = collition.get_collider() as Blade
	var shape = blade.get_node("CollisionShape2D").shape as RectangleShape2D
	var width = shape.extents.x * 2
	var heigth = shape.extents.y * 2
	
	#Calculamos el punto relavito de donde pego la pelota
	#Ej, si la paleta tiene un ancho de 100px, el valor va a ser
	#entre -50 y 50 (supongo que porque lo mide desde el centro del objeto)
	var local_point = blade.to_local(collition.get_position())
	
	#Con esta cuenta, pasamos ese punto de contacto a una franja
	#entre 0 y el ancho total por ejemplo[0,100]
	var relative_x = local_point.x + width / 2.0
	var relative_y = local_point.y + heigth / 2.0
	
	#Si la pelota choca con la mitad de abajo de la paleta, el impuso es hacia abajo
	if relative_y >= heigth / 2.0:
		velocity = Vector2.DOWN * current_speed
		emit_blade_sound()
		return
	
	#Y en esta linea lo pasamos a un valor entre 0 y 1
	#para usarlo en el lerp
	var ratio = relative_x / width
	var angle = lerp(-75.0, 75.0, ratio)
	velocity = Vector2.UP.rotated(deg_to_rad(angle)) * current_speed
	emit_blade_sound()

func handle_brick_collition(collition: KinematicCollision2D):
	var brick = collition.get_collider() as Brick
	var sound_resourse = brick.hit() 
	emit_sound(sound_resourse)

func handle_horizontal_bounce():
	if abs(velocity.y) < 20:
		velocity.y = 50 * sign(velocity.y if velocity.y != 0 else -1.0)

func emit_sound(sound_resourse):
	audio_stream_player.stream = sound_resourse
	audio_stream_player.play()

#Este metodo esta para que al chocar y "empujar" la pelota
#de costado, el sonido se emita una sola vez
func emit_blade_sound():
	if (not can_emit_blade_sound): return
	can_emit_blade_sound = false
	blade_sound_timer.start()
	emit_sound(preload("res://assets/sounds/ball_hit2.ogg"))

func _on_blade_sound_timer_timeout() -> void:
	can_emit_blade_sound = true
