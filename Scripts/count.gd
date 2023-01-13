extends Label

var accum=0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	accum += delta
	set_text(str(int(accum)))
	