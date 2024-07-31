extends Node2D

var choise = randi_range(1,4)
var choise2 
var enemyType
var enemy
var posX
var posY

@onready var currentWave:int = 1
@onready var player = get_parent()
@onready var upgradeScreen = $"../CanvasLayer/UpgradeScreen"
@onready var Timer1 = $RandomTimer
@onready var Timer2 = $SpawnCoolDown
@onready var waveTimer = $WaveTimer
@onready var spawnerCD = $SpawnerCD
@onready var canSpawn:bool = true
@onready var isSpawned:bool = false
@onready var isStopped:bool = false
@onready var eldenRing = $"../FinalBattle"
@onready var DangerTheme = $"../BGMusicDanger"
@onready var survivalhalay = $"../survivalhalay"
	
func _ready():
	DangerTheme.play()
	upgradeScreen.reset_upgrades()
	set_timer_autostart()
	
func _process(delta):
	posX = player.global_position.x
	posY = player.global_position.y
	
	if canSpawn == false and player.enemy_nearby == false:
		canSpawn = true
		upgradeScreen.getScrap()
		spawnerCD.start()
	
	if (currentWave >= upgradeScreen.highScore):
		upgradeScreen.highScore = currentWave
		upgradeScreen.save_data()
		

func _on_timer_timeout():
	choise = randi_range(1,4)

func _on_timer_2_timeout():
	if currentWave <= 3 :
		enemyType = randi_range(1,10)
		if enemyType <= 7:
			enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
			add_child(enemy)
		elif enemyType >= 8:
			enemy = preload("res://Game/Enemy/kamikaze.tscn").instantiate()
			add_child(enemy)
			
	if currentWave >= 4 and currentWave < 6 :
		if DangerTheme.playing == true:
			DangerTheme.stop()
			print("zaaa")
		survivalhalay.play()
		enemyType = randi_range(1,10)
		if enemyType <= 7:
			enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
			add_child(enemy)
		elif enemyType <= 9 and enemyType >= 8:
			enemy = preload("res://Game/Enemy/kamikaze.tscn").instantiate()
			add_child(enemy)
		elif enemyType == 10:
			enemy = preload("res://Game/Enemy/hulk.tscn").instantiate()
			add_child(enemy)
			
	if currentWave >= 6 and currentWave < 8:
		enemyType = randi_range(1,10)
		if enemyType <= 5:
			enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
			add_child(enemy)
		elif enemyType <= 8 and enemyType >= 6:
			enemy = preload("res://Game/Enemy/kamikaze.tscn").instantiate()
			add_child(enemy)
		elif enemyType >= 9:
			enemy = preload("res://Game/Enemy/hulk.tscn").instantiate()
			add_child(enemy)
			
	if currentWave >=8 and currentWave<10:
		enemyType = randi_range(1,10)
		if enemyType <= 5:
			enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
			enemy.playerDamage = 1.3
			add_child(enemy)
		elif enemyType <= 7 and enemyType >= 6:
			enemy = preload("res://Game/Enemy/kamikaze.tscn").instantiate()
			add_child(enemy)
		elif enemyType >= 8:
			enemy = preload("res://Game/Enemy/hulk.tscn").instantiate()
			add_child(enemy)
	if currentWave >=10 and currentWave < 12:	
		enemyType = randi_range(1,10)
		if enemyType <= 4:
			enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
			add_child(enemy)
			enemy.playerDamage = 2
			enemy.enemyHealth = 6
			enemy.sprite.texture = load("res://Sprites/uzaygemisi/EnemyShips/Bison_Top_dir5.png")
			enemy.sprite.scale = Vector2(0.06,0.06)
		elif enemyType <= 6 and enemyType >= 5:
			enemy = preload("res://Game/Enemy/kamikaze.tscn").instantiate()
			add_child(enemy)
		elif enemyType >= 7:
			enemy = preload("res://Game/Enemy/hulk.tscn").instantiate()
			add_child(enemy)
	if currentWave >=12 and currentWave <14:	
		enemyType = randi_range(1,10)
		if enemyType <= 2:
			enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
			add_child(enemy)
			enemy.playerDamage = 2
			enemy.enemyHealth = 7
			enemy.sprite.texture = load("res://Sprites/uzaygemisi/EnemyShips/Bison_Top_dir5.png")
			enemy.sprite.scale = Vector2(0.06,0.06)
		elif enemyType <= 5 and enemyType >= 3:
			enemy = preload("res://Game/Enemy/kamikaze.tscn").instantiate()
			add_child(enemy)
		elif enemyType >= 6:
			enemy = preload("res://Game/Enemy/hulk.tscn").instantiate()
			add_child(enemy)
			enemy.playerDamage = 1.5
	if currentWave >=14 and currentWave <16:
		enemyType = randi_range(1,10)
		if enemyType <= 1:
			enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
			enemy.playerDamage = 2
			enemy.enemyHealth = 11
			enemy.sprite.texture = load("res://Sprites/uzaygemisi/EnemyShips/Bison_Top_dir5.png")
			enemy.sprite.scale = Vector2(0.06,0.06)
			add_child(enemy)
		elif enemyType <= 5 and enemyType >= 2:
			enemy = preload("res://Game/Enemy/kamikaze.tscn").instantiate()
			add_child(enemy)
		elif enemyType >= 6:
			enemy = preload("res://Game/Enemy/hulk.tscn").instantiate()
			enemy.playerDamage = 2
			enemy.sprite.texture = load("res://Sprites/uzaygemisi/EnemyShips/Diablo_Top_dir5.png")
			enemy.sprite.scale = Vector2(1,1)
			add_child(enemy)
	if currentWave >=16 and currentWave <18:
		enemyType = randi_range(1,10)
		if enemyType <= 1:
			enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
			enemy.sprite.texture = load("res://Sprites/uzaygemisi/EnemyShips/Bison_Top_dir5.png")
			enemy.sprite.scale = Vector2(0.06,0.06)
			enemy.playerDamage = 2
			add_child(enemy)
		elif enemyType <= 6 and enemyType >= 2:
			enemy = preload("res://Game/Enemy/kamikaze.tscn").instantiate()
			add_child(enemy)
		elif enemyType >= 7:
			enemy = preload("res://Game/Enemy/hulk.tscn").instantiate()
			enemy.playerDamage = 2
			enemy.sprite.texture = load("res://Sprites/uzaygemisi/EnemyShips/Diablo_Top_dir5.png")
			enemy.sprite.scale = Vector2(1,1)
			add_child(enemy)
	if currentWave >=17:
		enemyType = randi_range(1,10)
		if enemyType <= 1:
			enemy = preload("res://Game/Enemy/hunter.tscn").instantiate()
			enemy.playerDamage = 2
			enemy.sprite.texture = load("res://Sprites/uzaygemisi/EnemyShips/Bison_Top_dir5.png")
			enemy.sprite.scale = Vector2(0.06,0.06)
			add_child(enemy)
		elif enemyType <= 8 and enemyType >= 2:
			enemy = preload("res://Game/Enemy/kamikaze.tscn").instantiate()
			enemy.playerDamage = 3
			enemy.enemyMaxSpeed = 1700
			add_child(enemy)
		elif enemyType >= 9:
			enemy = preload("res://Game/Enemy/hulk.tscn").instantiate()
			enemy.playerDamage = 2
			enemy.sprite.texture = load("res://Sprites/uzaygemisi/EnemyShips/Diablo_Top_dir5.png")
			enemy.sprite.scale = Vector2(1,1)
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
	
	
func set_timer_autostart(): 
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
	canSpawn = false
	set_timer_autostart()
	#spawnerCD.start()
	#upgradeScreen.getScrap()


func _on_spawner_cd_timeout():
	#print("spawner is active again")
	if (Timer2.wait_time > 0.5):
		Timer2.wait_time -= 0.2
	canSpawn = true
	isSpawned = false
	isStopped = false
	currentWave += 1
	set_timer_autostart()
	if currentWave == 8:
		DangerTheme.stop()
		eldenRing.play()
