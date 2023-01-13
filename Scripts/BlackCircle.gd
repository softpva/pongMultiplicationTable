extends StaticBody2D

var color = Color(0,0,0)

func _ready():
	add_to_group("BlackBricks")
	set_fixed_process(true)
	
func _fixed_process(delta):
	var bodies = 0
	pass

