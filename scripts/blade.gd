extends StaticBody2D
class_name Blade
signal on_get_power(code: String)

@onready var right: Area2D = $Wall_detectors/right
@onready var left: Area2D = $Wall_detectors/left

var speed = 600
var borders = {
	"left" : true,
	"rigth" : true
}

func init_blade( init_position):
	position = init_position

func _physics_process(delta: float) -> void:
	if(get_axis().x > 0 and borders["rigth"]):
		borders["left"] = true
		position.x += speed * delta * get_axis().x
	if(get_axis().x < 0 and borders["left"]):
		borders["rigth"] = true
		position.x += speed * delta * get_axis().x


func get_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("rigth")) - int(Input.is_action_pressed("left"))
	return axis.normalized()

func apply_power(power_code):
	on_get_power.emit(power_code)
	
	match power_code:
			PowerType.Types.BIG_BLADE:
				get_parent().BIG_BLADE_CASE(self)
			PowerType.Types.SMALL_BLADE:
				get_parent().SMALL_BLADE_CASE(self)

func change_size(new_value):
	scale.x = new_value
	if right.get_overlapping_bodies().size() > 0:
		position.x -= 50
		borders["rigth"] = true
	if left.get_overlapping_bodies().size() > 0:
		position.x += 50
		borders["left"] = true

func _on_rigth_detector_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		borders["rigth"] = false

func _on_left_detector_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		borders["left"] = false
