extends Node2D

var choise = randi_range(1,4)
var choise2 
var enemyType
var enemy
var posX
var posY

@onready var player = get_parent()
@onready var upgradeScreen = $"../CanvasLayer/UpgradeScreen"
@onready var Timer1 = $RandomTimer
@onready var Timer2 = $SpawnCoolDown
@onready var waveTimer = $WaveTimer
@onready var spawnerCD = $SpawnerCD
@onready var canSpawn:bool = true
@onready var isSpawned:bool = false
@onready var isStopped:bool = false
	
func _ready():
	pass

func _process(delta):
	posX = player.global_position.x
	posY = player.global_position.y
	
func _on_timer_timeout():
	choise = randi_range(1,4)

func _on_timer_2_timeout():
	enemyType = randi_range(1,10)
	if enemyType <= 4:
		enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
		add_child(enemy)
	elif enemyType <= 8 and enemyType >= 5:
		enemy = preload("res://Game/Enemy/kamikaze.tscn").instantiate()
		add_child(enemy)
	elif enemyType >= 9:
		enemy = preload("res://Game/Enemy/hulk.tscn").instantiate()
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
			enemy_position = Vector2(posX+randx1,posY+1500)
		elif choise2 == 2:
			enemy_position = Vector2(posX+2500,posY+randy1)
		elif choise2 == 3:
			enemy_position = Vector2(posX+randx1,posY+-1500)
	elif choise == 2:
		if choise2 == 1:
			enemy_position = Vector2(posX+2500,posY+randy2)
		elif choise2 == 2:
			enemy_position = Vector2(posX+randx2,posY+-1500)
		elif choise2 == 3:
			enemy_position = Vector2(posX+-2500,posY+randy2)
	elif choise == 3:
		if choise2 == 1:
			enemy_position = Vector2(posX+randx3,posY+-1500)
		elif choise2 == 2:
			enemy_position = Vector2(posX+-2500,posY+randy1)
		elif choise2 == 3:
			enemy_position = Vector2(posX+randx3,posY+1500)
	elif choise == 4:
		if choise2 == 1:
			enemy_position = Vector2(posX+-2500,posY+randy3)
		elif choise2 == 2:
			enemy_position = Vector2(posX+randx2,posY+1500)
		elif choise2 == 3:
			enemy_position = Vector2(posX+2500,posY+randy3)
	enemy.position = enemy_position
	
	
func set_timer_autostart(isStarted: bool): # this func is no longer in need a bool parameter.
	#print("spawned")
	if canSpawn:
		if !isSpawned:
			Timer1.autostart = true
			Timer2.autostart = true
			Timer1.start()
			Timer2.start()
			waveTimer.start()
			isSpawned = true
	else:
		if !isStopped:
			Timer1.autostart = false
			Timer2.autostart = false
			Timer1.stop()
			Timer2.stop()
			isStopped = true


func _on_wave_timer_timeout():
	#print("stopped")
	upgradeScreen.getScrap()
	canSpawn = false
	set_timer_autostart(false)
	spawnerCD.start()


func _on_spawner_cd_timeout():
	#print("spawner is active again")
	canSpawn = true
	isSpawned = false
	isStopped = false
