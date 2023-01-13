extends Node2D

func _ready():
	randomize()
	putNewBrick(load("res://Scenes/BlueBrick.tscn"))
	putNewBrick(load("res://Scenes/RedBrick.tscn"))
	putNewBrick(load("res://Scenes/GreenCircle.tscn"))
	putNewBrick(load("res://Scenes/TriBrick.tscn"))
	putNewBrick(load("res://Scenes/BlackCircle.tscn"))

func putNewBrick(brickScene):
	var grade = get_node("/root/mathShot").grade
	var pos = Vector2((randi() % int(grade.x) + 1) * 32, (randi() % int(grade.y) + 1) * 32)
	var brick = brickScene.instance()
	brick.set_pos(pos)
	get_node("/root/mathShot/Bricks").add_child(brick)
