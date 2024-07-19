extends VideoStreamPlayer


@onready var character = $"../../../Character"
var isplaying:bool
var counter = 1
var videopath
func _process(delta):
	if is_playing() == false:
		isplaying = false
		hide()
	if Input.is_action_just_pressed("skip"):
		stop()
		isplaying = false
	position.x /=4
	position.y/=4
	
	if videopath == "res://Game/videos/2.3.ogv":
		if visible == false:
			get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func playvideo(path):
	position = character.position
	stream = load(path)
	play()
	isplaying = true
	show()
	counter = 2
	videopath = path
		
