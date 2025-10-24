extends StaticBody2D
class_name Blade

var speed = 600
var borders = {
	"left" : -1000000,
	"rigth" : 1000000
}

func _physics_process(delta: float) -> void:
	position.x += speed * delta * get_axis().x
	position.x = clamp(position.x, borders["left"],borders["rigth"])

func get_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("rigth")) - int(Input.is_action_pressed("left"))
	return axis.normalized()

func _on_left_detector_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		borders["left"] = position.x

func _on_rigth_detector_2_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		borders["rigth"] = position.x
