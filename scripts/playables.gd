extends Node2D

const BALL = preload("res://scenes/ball.tscn")
const BLADE = preload("res://scenes/blade.tscn")

func create_playables(initial_position):
	remove_playables()

	var ball_instance = BALL.instantiate() as Ball
	var blade_instance = BLADE.instantiate() as Blade

	var marker_position = initial_position.position
	
	blade_instance.init_blade(marker_position)
	ball_instance.init_ball(blade_instance, marker_position)

	call_deferred("add_child",blade_instance)
	call_deferred("add_child",ball_instance)

func remove_playables():
	for node in get_children():
		remove_child(node)

func MULTI_BALL_CASE(ball: Ball):
	var ball_1_instance = BALL.instantiate() as Ball
	var ball_2_instance = BALL.instantiate() as Ball
	
	ball_1_instance.clone_ball(ball, 20, 45)
	ball_2_instance.clone_ball(ball, -20, -45)

	call_deferred("add_child",ball_1_instance)
	call_deferred("add_child",ball_2_instance)


func BIG_BLADE_CASE(blade: Blade):
	if(blade.scale.x < 2):
		blade.change_size(blade.scale.x + 0.5)

func SMALL_BLADE_CASE(blade: Blade):
	if(blade.scale.x > 0.5):
		blade.change_size(blade.scale.x - 0.25)
