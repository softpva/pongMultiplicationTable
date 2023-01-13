#extends StaticBody2D
#extends RigidBody2D
extends KinematicBody2D

const ballScene = preload("res://MiniScenes/Ball.tscn")
onready var lbRes = get_node("/root/mathShot/Operation/res")
onready var lbOp1 = get_node("/root/mathShot/Operation/op1")
onready var lbOp2 = get_node("/root/mathShot/Operation/op2")
onready var lbSay = get_node("/root/mathShot/Operation/say")
onready var lbOp = get_node("/root/mathShot/Operation/op")
onready var part = get_node("/root/mathShot/Bricks/Particles")
const ballScene = preload("res://MiniScenes/Ball.tscn")
const redBrickScene = preload("res://MiniScenes/RedBrick.tscn")
const blueBrickScene = preload("res://MiniScenes/BlueBrick.tscn")
const greenBrickScene = preload("res://MiniScenes/GreenCircle.tscn")
const triBrickScene = preload("res://MiniScenes/TriBrick.tscn")
const blackBrickScene = preload("res://MiniScenes/BlackCircle.tscn")

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	set_pos(get_global_mouse_pos())
	pass
#	var bodies = get_collision_
#	var bodies = get_colliding_bodies()

#	# Get collisiona
#	for body in bodies:
#		# sounds for any collision
#		get_node("sounds").play("sound_shoot")
#		# Check collisions
#		if body.is_in_group("BlueBricks"):
#			sum(int(body.get_node("lb").get_text()))
#			explode(Color(0,0,255))
#			body.queue_free()
#			putNewBrick(blueBrickScene)
#		if body.is_in_group("TriBricks"):
#			putNewBall()
#			sum(int(body.get_node("lb").get_text()))
#			explode(Color(255,255,0))
#			body.queue_free()
#			putNewBrick(triBrickScene)
#		if body.is_in_group("RedBricks"):
#			sum(int(body.get_node("lb").get_text()))
#			explode(Color(255,0,0))
#			# free this body
#			body.queue_free()
#			putNewBrick(redBrickScene)
#		if body.is_in_group("Balls"):
#			explode(Color(255,255,255))
#			body.queue_free()
#		if body.is_in_group("BlackBricks"):
#			sum(int(body.get_node("lb").get_text()))
#			explode(Color(0,0,0))
#			body.queue_free()
#			putNewBrick(blackBrickScene)
#		if body.is_in_group("GreenBricks"):
#			sum(int(body.get_node("lb").get_text()))
#			explode(Color(0,255,0))
#			body.queue_free()
#			putNewBrick(greenBrickScene)
#
#	
#func putNewBrick(brickScene):
#	var grade = get_node("/root/mathShot/Bricks").grade
#	print(grade)
#	var pos = Vector2((randi() % int(grade.x) + 1) * 32, (randi() % int(grade.y) + 1) * 32)
#	print(pos)
#	var brick = brickScene.instance()
#	brick.set_pos(pos)
#	get_node("/root/mathShot/Bricks").add_child(brick)
#
#func explode(color):
#	get_node("sounds").play("sound_explode")
#	part.set_global_pos(get_pos())
#	part.set_color(color)
#	part.set_emitting(true)
#	part.set_emit_timeout(0.2)
#
#func putNewBall():
#	var ball = ballScene.instance()
#	ball.set_pos(get_pos() - Vector2(0,16))
#	get_tree().get_root().add_child(ball)
#
#func sum(number):
#	var res = int(lbRes.get_text())
#	res += number
#	lbRes.set_text(str(res))
#	checkOperation()
#	
#func mul(number):
#	var res = int(lbRes.get_text())
#	res *= number
#	lbRes.set_text(str(res))
#	checkOperation()
#
#func checkOperation():
#	var res = int(lbRes.get_text())
#	var op1 = int(lbOp1.get_text())
#	var op2 = int(lbOp2.get_text())
#	var op = lbOp.get_text()
#	if ( op == 'x' ):
#		if ( op1 * op2 == res):
#			lbSay.set_text("Valeu!!! " + str(op1) + " " + op + " " + str(op2) + " = " + str(res))
#			if (op2 == 9):
#				randomize()
#				op1 = randi() % 7 + 2
#				op2 = 1
#			else:
#				op2 += 1
#			res = 0
#			lbRes.set_text(str(res))
#			lbOp1.set_text(str(op1))
#			lbOp2.set_text(str(op2))
#			lbOp.set_text(op)
#	# Rize the paddle's size when pos.y grow
#	set_pos(get_viewport().get_mouse_pos())
#	set_scale(Vector2(get_viewport().get_mouse_pos().y/600,get_viewport().get_mouse_pos().y/600))


func _input(event):
	# Create a new ball instance when any mouse button is pressed
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		var ball = ballScene.instance()
		ball.set_pos(get_pos() - Vector2(0,16))
		get_tree().get_root().add_child(ball)
		ball.add_to_group("Balls")
		lbSay.set_text("")