extends Node2D
signal on_destroy_brick(quantity: int)

var total_bricks: int = 0
var destructibles_bricks: int = 0

func _ready() -> void:
	for brick in get_children():
		total_bricks += 1
		if not brick.brick_color == Brick.Bricks_color.INDESTRUCTIBLE:
			destructibles_bricks += 1

func _on_child_exiting_tree(_node: Node) -> void:
	destructibles_bricks -= 1
	on_destroy_brick.emit(destructibles_bricks)
