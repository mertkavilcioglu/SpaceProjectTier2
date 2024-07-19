extends Sprite2D

@onready var station1 = $"../karagünes_atolyesi"
@onready var station2 = $"../korsan_istasyonu"
@onready var station3 = $"../themis"
@onready var station4 = $"../themis_uydu"
@onready var character = $"../Character"
var camera
var screen_center
var direction
var distance_from_center = 450
var station_position_path


func _ready():
	station_changer("1")

func _process(delta):
	direct_to_mission(station_position_path)
	show()
	if station1.body_entered == true:
		hide()

func station_changer(stationid:String):
	if stationid == "1":
		station_position_path = station1.global_position
	if stationid =="2":
		station_position_path = station2.global_position
	if stationid =="3":
		station_position_path = station3.global_position
	if stationid =="4":
		station_position_path = station4.global_position
	
	
func direct_to_mission(target_position):
	camera = get_viewport().get_camera_2d()
	screen_center = camera.global_position
	direction = (target_position - camera.global_position).normalized()
	
	look_at(target_position)
	position = camera.global_position + direction * distance_from_center
	
