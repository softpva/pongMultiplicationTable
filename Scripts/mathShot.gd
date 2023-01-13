extends Node2D

export var yearToExpire = 2023
const grade = Vector2(14,18)

func _ready():
	randomize()
	var tabuada = randi() % 11 + 2
	get_node("Operation/op1").set_text(str(tabuada))
	if yearToExpire < OS.get_datetime().year:
		get_node("Operation/say").set_text("O JOGO EXPIROU...")
		get_node("Paddle1").queue_free()
	else:
		get_node("Operation/say").set_text("Tabuada do " + str(tabuada))