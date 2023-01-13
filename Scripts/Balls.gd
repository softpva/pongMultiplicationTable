extends Node2D

const ballScene = preload("res://Scenes/Ball.tscn")

func _ready():
	set_process(true)

func _process(delta):
	if( get_child_count() < 1):
		var ball = ballScene.instance()
		ball.set_pos(Vector2(232,768))
		ball.add_to_group("balls")
		add_child(ball)