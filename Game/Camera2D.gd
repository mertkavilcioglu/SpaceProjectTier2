extends Camera2D

@onready var character = $"../Character"
var prev_speed = 0.0
var current_speed = 0.0
var current_acceleration = 0.0
@onready var canvaslayer2 = get_node("CanvasLayer2")

	
func _process(delta):
	prev_speed = current_speed
	current_speed = character.get_real_velocity().length()
	current_acceleration = (current_speed - prev_speed) / delta
	if character.get_real_velocity().length() < 500 and current_acceleration > 0:
		camera_shake()
	if offset != Vector2(0,0):
		offset.x = lerpf(offset.x,0,5*delta)
		offset.y = lerpf(offset.y,0,5*delta)


func camera_shake():
	var random_offset_number = randf_range(-2,2)
	var random_offset:Vector2 = Vector2(-random_offset_number,random_offset_number)
	offset = random_offset

