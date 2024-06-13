extends Node2D

@onready var spawner = $"../../Character/SpawnerHIGH"

func _on_area_2d_body_entered(body):
	if body is Player:
		spawner.set_timer_autostart(true)
		print("SPAWN")


func _on_area_2d_body_exited(body):
	if body is Player:
		spawner.set_timer_autostart(false)
		print("noSPAWN")
