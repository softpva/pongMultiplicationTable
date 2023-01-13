extends RigidBody2D

export var speedUp = 4
export var maxSpeed = 200
onready var lbRes = get_node("/root/mathShot/Operation/res")
onready var lbOp1 = get_node("/root/mathShot/Operation/op1")
onready var lbOp2 = get_node("/root/mathShot/Operation/op2")
onready var lbSay = get_node("/root/mathShot/Operation/say")
onready var lbOp = get_node("/root/mathShot/Operation/op")
onready var part = get_node("/root/mathShot/Bricks/Particles")
const ballScene = preload("res://Scenes/Ball.tscn")
const redBrickScene = preload("res://Scenes/RedBrick.tscn")
const blueBrickScene = preload("res://Scenes/BlueBrick.tscn")
const greenBrickScene = preload("res://Scenes/GreenCircle.tscn")
const triBrickScene = preload("res://Scenes/TriBrick.tscn")
const blackBrickScene = preload("res://Scenes/BlackCircle.tscn")

func _ready():
	set_fixed_process(true)
	# set direction and velocity with ***randonomizadamente
	randomize()
	var i = randi()%2
	if i == 0:
		set_linear_velocity(Vector2(200*randf(),-200*randf()))
	else:
		set_linear_velocity(Vector2(-200*randf(),-200*randf()))

func _fixed_process(delta):
	var bodies = get_colliding_bodies()
	# Get collisiona
	for body in bodies:
		# sounds for any collision
		get_node("sounds").play("sound_shoot")
		# Check collisions
		if body.is_in_group("BlueBricks"):
			deleteBrick(body, blueBrickScene)
#			sum(int(body.get_node("lb").get_text()))
#			explode(Color(0,0,255))
#			body.queue_free()
#			putNewBrick(blueBrickScene)
		if body.is_in_group("TriBricks"):
			deleteBrick(body, triBrickScene)
			putNewBall()
#			sum(int(body.get_node("lb").get_text()))
#			explode(Color(255,255,0))
#			body.queue_free()
#			putNewBrick(triBrickScene)
		if body.is_in_group("RedBricks"):
			deleteBrick(body,redBrickScene)
#			sum(int(body.get_node("lb").get_text()))
#			explode(Color(255,0,0))
#			body.queue_free()
#			putNewBrick(redBrickScene)
		if body.is_in_group("Balls"):
			explode(Color(255,255,255))
			body.queue_free()
		if body.is_in_group("BlackBricks"):
			deleteBrick(body, blackBrickScene)
#			sum(int(body.get_node("lb").get_text()))
#			explode(Color(0,0,0))
#			body.queue_free()
#			putNewBrick(blackBrickScene)
		if body.is_in_group("GreenBricks"):
			deleteBrick(body, greenBrickScene)
#			sum(int(body.get_node("lb").get_text()))
#			explode(Color(0,255,0))
#			body.queue_free()
#			putNewBrick(greenBrickScene)
		if body.get_name() == "Paddle":
			lbSay.set_text("")
			var speed = get_linear_velocity().length()
		# USING SIMPLE REFLEXION TO SET BALL'S DIRECTION
			set_linear_velocity(get_linear_velocity().normalized() * min(speed+speedUp, maxSpeed))
		# USING ANCHOR TO SET BALL'S DIRECTION 
#			var direction = get_pos() - body.get_node("Anchor").get_global_pos()
#			set_linear_velocity(direction.normalized() * min(speed+speedUp, maxSpeed))
	# if ball over the botton then free the object and set zero to result
	if get_pos().y > get_viewport_rect().end.y:
		if lbRes.get_text() != "0" :
			pass
#			lbSay.set_text("Ahhhh...zerou!")
		else:
			lbSay.set_text("Tabuada do " + lbOp1.get_text())
#		lbRes.set_text("0")
		queue_free()

func deleteBrick(brickToDel, sceneToNewInstance):
	sum(int(brickToDel.get_node("lb").get_text()))
	explode(brickToDel.color)
	brickToDel.queue_free()
	putNewBrick(sceneToNewInstance)
	
func putNewBrick(brickScene):
	var grade = get_node("/root/mathShot").grade
	var pos = Vector2((randi() % int(grade.x) + 1) * 32, (randi() % int(grade.y) + 1) * 32)
	var brick = brickScene.instance()
	brick.set_pos(pos)
	get_node("/root/mathShot/Bricks").add_child(brick)
	checkOperation(brick)

func explode(color):
	get_node("sounds").play("sound_explode")
	part.set_global_pos(get_pos())
	part.set_color(color)
	part.set_emitting(true)
	part.set_emit_timeout(0.2)

func putNewBall():
	var ball = ballScene.instance()
	ball.set_pos(get_pos() - Vector2(0,16))
	ball.add_to_group("balls")	
	get_node("/root/mathShot/Balls").add_child(ball)

func sum(number):
	var res = int(lbRes.get_text())
	res += number
	lbRes.set_text(str(res))
#	checkOperation()

func mul(number):
	var res = int(lbRes.get_text())
	res *= number
	lbRes.set_text(str(res))
#	checkOperation()

func checkOperation(brick):
	var res = int(lbRes.get_text())
	var op1 = int(lbOp1.get_text())
	var op2 = int(lbOp2.get_text())
	var op = lbOp.get_text()
	if ( op == 'x' ):
		if ( op1 * op2 == res):
			lbSay.set_text("Valeu!!! " + str(op1) + " " + op + " " + str(op2) + " = " + str(res))
			if (op2 == 9):
				randomize()
				op1 = randi() % 7 + 2
				op2 = 1
				lbSay.set_text("Tabuada do " + str(op1))
			else:
				op2 += 1
			res = 0
			lbRes.set_text(str(res))
			lbOp1.set_text(str(op1))
			lbOp2.set_text(str(op2))
			lbOp.set_text(op)
			var balls = get_tree().get_nodes_in_group("balls")
			for ball in balls:
				ball.explode(Color(255,255,255))
				ball.queue_free()
		elif ( op1 * op2 < res) : # se resltado passou do possível à multiplicação de op1 e op2
			var val = int(brick.get_node("lb").get_text())
			val *= -1
			brick.get_node("lb").set_text(str(val))