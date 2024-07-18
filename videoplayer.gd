extends VideoStreamPlayer


@onready var character = $"../../../Character"
var isplaying:bool
var counter = 1
func _process(delta):
	if is_playing() == false:
		isplaying = false
		hide()
	if Input.is_action_just_pressed("skip"):
		stop()
		isplaying = false
	position.x /=4
	position.y/=4

func playvideo(path):
	position = character.position
	stream = load(path)
	play()
	isplaying = true
	show()
	counter = 2

