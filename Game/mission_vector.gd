extends Sprite2D

@onready var station1 = $"../karagünes_atolyesi"
@onready var station2 = $"../Station2"
@onready var station3 = $"../Station3"
@onready var character = $"../Character"
var camera
var screen_center
var direction
var distance_from_center = 450
var station_position_path
var counter = 1

func _process(delta):
	station_changer()
	direct_to_mission(station_position_path)
	show()
	if station1.body_entered == true:
		hide()
	#	if station1.dialogue.visible == true:
		#	counter = 2
		#if station2.dialogue.visible == true:
		#	counter = 3
		#elif station3.dialogue.visible == true:
		#	counter = 4


func station_changer():
	if counter == 1:
		station_position_path = station1.global_position
	#elif counter == 2:
		#station_position_path = station2.global_position
	#elif counter == 3:
		#station_position_path = station3.global_position
	#elif counter == 4:
	#	station_position_path = Vector2(0,0)
		hide()
	
	
func direct_to_mission(target_position):
	camera = get_viewport().get_camera_2d()
	screen_center = camera.global_position
	direction = (target_position - camera.global_position).normalized()
	
	look_at(target_position)
	position = camera.global_position + direction * distance_from_center
	
