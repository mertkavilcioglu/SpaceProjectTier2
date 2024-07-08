extends Camera2D

@onready var character = $"../Character"
var prev_speed = 0.0
var current_speed = 0.0
var current_acceleration = 0.0
@onready var canvaslayer2 = get_node("CanvasLayer2")
@onready var enemy_alert = $CanvasLayer2/enemy_alert




func _ready():
	enemy_alert.global_position = get_viewport_rect().size/2 + Vector2(0,-200)
	
func _process(delta):
	prev_speed = current_speed
	current_speed = character.get_real_velocity().length()
	current_acceleration = (current_speed - prev_speed) / delta
	if character.get_real_velocity().length() < 300 and character.get_real_velocity().length() != 0:
		camera_shake()
	if offset != Vector2(0,0):
		offset.x = lerpf(offset.x,0,5*delta)
		offset.y = lerpf(offset.y,0,5*delta)



func camera_shake():
	var random_offset_number = randf_range(-3,3)
	var random_offset:Vector2 = Vector2(-random_offset_number,random_offset_number)
	offset = random_offset

