extends Node2D

@onready var spawner = $"../EnemySpawnerSURVIVAL"

func _on_area_2d_body_entered(body):
	if body is Player:
		spawner.set_timer_autostart(true)
		print("SPAWN")

