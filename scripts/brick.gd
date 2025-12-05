extends StaticBody2D
class_name Brick

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

var texture_hits_folder
enum Bricks_color {RED, GREEN, BLUE, PURPLE, ORANGE, INDESTRUCTIBLE, YELLOW }

@export var power_probability: float = 0.10
@export var power_type: PowerType = null
@export var brick_color: Bricks_color:
	set(value):
		brick_color = value
		match value:
			Bricks_color.RED:
				texture_selected = preload("res://assets/bricks/Red/red_brick.png")
				texture_hits_folder = "res://assets/bricks/Red/"
			Bricks_color.GREEN:
				texture_selected = preload("res://assets/bricks/Green/green_brick.png")
				texture_hits_folder = "res://assets/bricks/Green/"
			Bricks_color.BLUE:
				texture_selected = preload("res://assets/bricks/Blue/blue_brick.png")
				texture_hits_folder = "res://assets/bricks/Blue/"
			Bricks_color.PURPLE:
				texture_selected = preload("res://assets/bricks/Purple/purple_brick.png")
				texture_hits_folder = "res://assets/bricks/Purple/"
			Bricks_color.ORANGE:
				texture_selected = preload("res://assets/bricks/Orange/orange_brick.png")
				texture_hits_folder = "res://assets/bricks/Orange/"
			Bricks_color.YELLOW:
				texture_selected = preload("res://assets/bricks/Yellow/yellow_brick.png")
				texture_hits_folder = "res://assets/bricks/Yellow/"
			Bricks_color.INDESTRUCTIBLE:
				texture_selected = preload("res://assets/bricks/Indestructible/indestructible_brick.png")
@export_range(1, 4, 1) var hits_point: int = 1

var current_hits_point: int
var texture_selected: Texture2D

func _ready() -> void:
	if(brick_color == 0):
		brick_color = Bricks_color.RED
	sprite.texture = texture_selected
	current_hits_point = hits_point

func hit() -> Resource:
	if(not brick_color == Bricks_color.INDESTRUCTIBLE):
		current_hits_point -= 1
		if(current_hits_point <= 0):
			collision_shape_2d.disabled = true
			var tween: Tween = get_tree().create_tween()
			tween.tween_property(self,"scale", Vector2(1.1,1.1), 0.1)
			tween.tween_property(self,"scale", Vector2(0.1,0.1), 0.1)
			tween.tween_callback(delete)
		else:
			sprite.texture = get_texture_by_hit_points()
		return preload("res://assets/sounds/ball_hit4.ogg")
	else:
		return  preload("res://assets/sounds/ball_hit3.ogg")

func get_texture_by_hit_points():
	match current_hits_point:
		1:
			return load(texture_hits_folder + "hit_3.png")
		2:
			return load(texture_hits_folder + "hit_2.png")
		3:
			return load(texture_hits_folder + "hit_1.png")
		_:
			print("Bricks only can be hitten 3 times")


func delete():
	randomize()
	if should_execute(power_probability):
		generate_power()
	queue_free()
	
func generate_power():
	const power_scene = preload("res://scenes/power.tscn")
	var instance = power_scene.instantiate() as Power
	instance.init_power(position, power_type)
	
	var bricks_container = get_parent()
	var level_scene = bricks_container.get_parent()
	level_scene.add_power_in_containier(instance)
	
func should_execute(probability: float) -> bool:
	return randf() < probability
  
