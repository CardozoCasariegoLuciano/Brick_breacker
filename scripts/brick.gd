extends StaticBody2D
class_name Brick

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

enum Bricks_color {RED, GREEN, BLUE, PURPLE, ORANGE, INDESTRUCTIBLE, YELLOW }

@export var brick_color: Bricks_color:
	set(value):
		brick_color = value
		match value:
			Bricks_color.RED:
				texture_selected = preload("res://assets/red_brick.png")
			Bricks_color.GREEN:
				texture_selected = preload("res://assets/green_brick.png")
			Bricks_color.BLUE:
				texture_selected = preload("res://assets/blue_brick.png")
			Bricks_color.PURPLE:
				texture_selected = preload("res://assets/purple_brick.png")
			Bricks_color.ORANGE:
				texture_selected = preload("res://assets/orange_brick.png")
			Bricks_color.YELLOW:
				texture_selected = preload("res://assets/yellow_brick.png")
			Bricks_color.INDESTRUCTIBLE:
				texture_selected = preload("res://assets/indestructible_brick.png")

var texture_selected: Texture2D


func _ready() -> void:
	if(brick_color == 0):
		brick_color = Bricks_color.RED
	sprite.texture = texture_selected

func hit() -> Resource:
	if(not brick_color == Bricks_color.INDESTRUCTIBLE):
		collision_shape_2d.disabled = true
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self,"scale", Vector2(1.1,1.1), 0.1)
		tween.tween_property(self,"scale", Vector2(0.1,0.1), 0.1)
		tween.tween_callback(delete)
		return preload("res://assets/sounds/ball_hit4.ogg")
	else:
		return  preload("res://assets/sounds/ball_hit3.ogg")

func delete():
	queue_free()
