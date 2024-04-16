extends Area2D

var movement_vector := Vector2(0, -1)

@export var speed := 2000.0

func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
		
	
func _on_body_entered(body):
	if body is Player:
		var player = body
		player.playerGetHit()
		queue_free()

