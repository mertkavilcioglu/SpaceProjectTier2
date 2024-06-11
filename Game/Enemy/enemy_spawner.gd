extends Node2D

var choise = randi_range(1,4)
var choise2 

@onready var Timer1 = $Timer
@onready var Timer2 = $SpawnCoolDown

func _ready():
	set_timer_autostart(false)

func _on_timer_timeout():
	choise = randi_range(1,4)

func _on_timer_2_timeout():
	var enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
	add_child(enemy)
	var randx1 = randi_range(0,575)
	var randx2 = randi_range(-575,575)
	var randx3 = randi_range(-575,0)
	var randy1 =  randi_range(-325,325)
	var randy2 = randi_range(-325,0)
	var randy3 = randi_range(0,325)
	var enemy_position

	choise2 = randi_range(1,3)
	
	if choise == 1:
		if choise2 == 1:
			enemy_position = Vector2(randx1,325)
		elif choise2 == 2:
			enemy_position = Vector2(575,randy1)
		elif choise2 == 3:
			enemy_position = Vector2(randx1,-325)
	elif choise == 2:
		if choise2 == 1:
			enemy_position = Vector2(575,randy2)
		elif choise2 == 2:
			enemy_position = Vector2(randx2,-325)
		elif choise2 == 3:
			enemy_position = Vector2(-575,randy2)
	elif choise == 3:
		if choise2 == 1:
			enemy_position = Vector2(randx3,-325)
		elif choise2 == 2:
			enemy_position = Vector2(-575,randy1)
		elif choise2 == 3:
			enemy_position = Vector2(randx3,325)
	elif choise == 4:
		if choise2 == 1:
			enemy_position = Vector2(-575,randy3)
		elif choise2 == 2:
			enemy_position = Vector2(randx2,325)
		elif choise2 == 3:
			enemy_position = Vector2(575,randy3)
	enemy.position = enemy_position
	
	
func set_timer_autostart(isStarted: bool):
	Timer1.autostart = isStarted
	Timer2.autostart = isStarted
	
	if isStarted:
		Timer1.start()
		Timer2.start()
		
	if !isStarted:
		Timer1.stop()
		Timer2.stop()

	
