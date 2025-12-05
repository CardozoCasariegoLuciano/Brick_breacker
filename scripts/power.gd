extends CharacterBody2D
class_name Power

@onready var icon: Sprite2D = $Icon

const speed = 400
var curren_power

func _physics_process(_delta: float) -> void:
	velocity.y = speed
	move_and_slide()
	
func _ready() -> void:
	set_sprite(curren_power)

func init_power(brik_position: Vector2, power_type: PowerType):
	position = brik_position

	if (power_type):
		curren_power = power_type.type
	else:
		const types = PowerType.Types
		curren_power = types[types.find_key(randi() % types.size())]


func set_sprite(power):
	const Types = PowerType.Types
	match power:
		Types.BIG_BLADE:
			icon.modulate = Color(1.0, 0.19, 0.19)
		Types.SMALL_BLADE:
			icon.modulate = Color(0.345, 0.57, 0.325)

func _on_screen_exited() -> void:
	queue_free()

func _on_blade_entered(body: Node2D) -> void:
	if body is Blade:
		body.apply_power(curren_power)
		queue_free()
