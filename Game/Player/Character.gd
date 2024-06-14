class_name Player 
extends CharacterBody2D

signal healthChanged
signal boostFuelChanged(fuel: float)
#**************** UPGRADE VARIABLES *****************
var maxHealth = 10
@onready var health:int = maxHealth
var damage: int = 1
var fireCD:float = 0.5
var guns:bool = false
#var speed: float = 500.0
#var fuel: float = 100.0
@onready var body = $body
@onready var wing = $wing
@onready var LevelPanel = get_node("Upgrade/NewLevel")
var level_counter = 1
const save_path = "user://game_save.save"

#**************** MOVEMENT-COMBAT VARIABLES and FUNCTIONS *****************
@export var Speed:float = 500
@export var MaxSpeed:float = Speed
@export var Acceleration:float = 10.0
@onready var Cam = $"../Camera2D"
var MousePosition = null
@onready var CanBoost:bool = true
@onready var BoostRefuel:bool = false
@onready var BoostFuel:float = 100.0
@onready var muzzle1=$Muzzle 
@onready var muzzle2=$Muzzle2
@onready var muzzle3=$Muzzle3
@onready var lasers=$"../Lasers"

@export var deathParticle : PackedScene 
@export var on_dialogue = false
@onready var isDead = false 
@onready var shockwave = $ShockwaveAnimationPlayer
@onready var hit_flash_anim_player = $HitFlashAnimationPlayer
@onready var chroma_player = $ChromaAnimationPlayer

var laser_scene = preload("res://Game/Player/laser.tscn")
signal laser_shot(laser)
var BoostCD:int = 3
var shoot_bas=false

var ghost_scene = preload("res://Game/Player/dash_ghost.tscn")
var ghost_scene2 = preload("res://Game/Player/dash_ghost2.tscn")
var sprite 
var sprite2
@onready var ghost_timer = $GhostTimer
@onready var muzzle_flash1 = $Muzzle/MuzzleFlashAnimationPlayer
@onready var muzzle_flash2 = $Muzzle2/MuzzleFlashAnimationPlayer
@onready var muzzle_flash3 = $Muzzle3/MuzzleFlashAnimationPlayer

@onready var enemy_nearby_area = $enemy_nearby_area
var enemy_nearby:bool = false
@onready var shader_animation = $"../Camera2D/CanvasLayer2/fade_animation"
@onready var canvaslayer2 = $"../Camera2D/CanvasLayer2"

func _ready():
	health = maxHealth
	shockwave.play("RESET")
	chroma_player.play("RESET")
	shader_animation.play("RESET")
	boostFuelChanged.emit()
	healthChanged.emit()

func _process(delta): 
	print(health)
	if (!isDead):
		if (!on_dialogue):
			upgradeChecker()
			if Input.is_action_pressed("Shoot"):
				if !shoot_bas:
					shoot_bas=true
					shoot_laser()
					await get_tree().create_timer(fireCD).timeout
					shoot_bas=false
	if is_enemy_nearby() == true and enemy_nearby== false:
		shader_animation.play("enemy_nearby_true")
		print(enemy_nearby)
		enemy_nearby = true
		canvaslayer2.visible = true
	elif is_enemy_nearby() == false and enemy_nearby == true:
		shader_animation.play("enemy_nearby_false")
		print(enemy_nearby)
		enemy_nearby = false
		#canvaslayer2.visible = false
		
		
func is_enemy_nearby() -> bool:
	for body in enemy_nearby_area.get_overlapping_bodies():
		if body is Enemy or body is EnemyH or body is EnemyHH or body is EnemyK:
			return true
			
	return false


func _physics_process(delta): 
	if(!isDead):
		if(!on_dialogue):
			if BoostFuel <100:
				BoostFuel += 20*delta
				boostFuelChanged.emit()
			
			var Motion = Vector2()
			Motion.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
			Motion.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
			velocity.x = move_toward(velocity.x, Motion.x * MaxSpeed , Acceleration)
			velocity.y = move_toward(velocity.y, Motion.y * MaxSpeed , Acceleration)
			
			if Input.is_action_pressed("Turbo"):
				if BoostFuel >= 100:
					CanBoost = true
				if BoostRefuel == false:
					if BoostFuel <0:
						BoostRefuel = true
					if BoostFuel > 0:
						if CanBoost == true:
							MaxSpeed = Speed*2
							velocity.x = move_toward(velocity.x, Motion.x * MaxSpeed , Acceleration*100)
							velocity.y = move_toward(velocity.y, Motion.y * MaxSpeed , Acceleration*100)
							sprite = $body
							sprite2 = $wing
							ghost_timer.start()
							instance_ghost()
							BoostFuel -= 105
							boostFuelChanged.emit()
							CanBoost = false
							await get_tree().create_timer(0.2).timeout
							ghost_timer.stop()
						elif CanBoost == false:
							MaxSpeed = Speed*2
							if BoostFuel > 0:
								BoostFuel -= 50*delta
								boostFuelChanged.emit()
							else: 
								MaxSpeed = Speed
					else:
						MaxSpeed = Speed
			else:
				MaxSpeed = Speed
				
			if BoostRefuel == true:
				if BoostFuel < 100:
					BoostFuel += 50*delta
					boostFuelChanged.emit()
				else:
					BoostRefuel = false
			if Input.is_action_just_released("Turbo"):
				if BoostFuel > 20:
					CanBoost = true
			move_and_slide()
			MousePosition = get_global_mouse_position()
			look_at(MousePosition)
			Cam.position = lerp(Cam.position, position, 5 * delta)
		elif(on_dialogue):
			velocity.x = move_toward(velocity.x, 0 , Acceleration)
			velocity.y = move_toward(velocity.y, 0 , Acceleration)
	elif(isDead):
		velocity.x = move_toward(velocity.x, 0 , Acceleration)
		velocity.y = move_toward(velocity.y, 0 , Acceleration)
		move_and_slide()
		Cam.position = lerp(Cam.position, position, 5 * delta)
	
func Boost_True():
	CanBoost = true
	print ("bum")
	
func shoot_laser():
	var l = laser_scene.instantiate()
	lasers.add_child(l)
	l.global_position = muzzle1.global_position
	l.rotation = rotation + PI/2
	emit_signal("laser_shot", l)
	if muzzle_flash1.is_playing():
		muzzle_flash1.stop()
	muzzle_flash1.play("muzzle_flash_anim")
	
	if(guns):
		var l2 = laser_scene.instantiate()
		lasers.add_child(l2)
		l2.global_position = muzzle2.global_position
		l2.rotation = rotation + PI/2
		emit_signal("laser_shot", l2)
		if muzzle_flash2.is_playing():
			muzzle_flash2.stop()
		muzzle_flash2.play("muzzle_flash_anim")
		var l3 = laser_scene.instantiate()
		lasers.add_child(l3)
		l3.global_position = muzzle3.global_position
		l3.rotation = rotation + PI/2
		emit_signal("laser_shot", l3)
		if muzzle_flash3.is_playing():
			muzzle_flash3.stop()
		muzzle_flash3.play("muzzle_flash_anim")

#**************** UPGRADE FUNCTIONS *****************
func LevelUp():
	level_counter+=1
	get_tree().paused = true
	LevelPanel.visible = true
	
	if level_counter == 2:
		body.texture = load("res://uzaygemisi/gövdeler/gövde lvl2.png")
		wing.texture = load("res://uzaygemisi/kanatlar/kanat lvl2 gövde 1.png")
	if level_counter == 3:
		body.texture = load("res://uzaygemisi/gövdeler/gövde lvl3.png")
		wing.texture = load("res://uzaygemisi/kanatlar/kanat lvl3 gövde 1.png")
	if level_counter == 4:
		body.texture = load("res://uzaygemisi/gövdeler/gövde lvl4.png")
		wing.texture = load("res://uzaygemisi/kanatlar/kanat lvl4 gövde 1.png")
	if level_counter == 5:
		body.texture = load("res://uzaygemisi/gövdeler/gövde lvl5.png")
		wing.texture = load("res://uzaygemisi/kanatlar/kanat lvl5 gövde 1.png")
		
		
	
	
func _on_get_level_pressed(): 
	LevelUp()


func _on_health_pressed():
	health+=10
	get_tree().paused = false
	LevelPanel.visible = false
	healthChanged.emit()
	LevelUp()
	


func _on_speed_pressed():
	MaxSpeed+=100.0
	get_tree().paused = false
	LevelPanel.visible = false
	


func _on_fuel_pressed():
	BoostFuel+=10.0
	get_tree().paused = false
	LevelPanel.visible = false


func _on_damage_pressed():
	damage+=1
	get_tree().paused = false
	LevelPanel.visible = false
	
func playerGetHit(damageTaken:int): 
	if(!isDead):
		emit_signal("hit") 
		if health > 0: 
			hit_flash_anim_player.play("hit_flash")
			health -= damageTaken #
		if health <= 0:
			hit_flash_anim_player.play("hit_flash")
			health = 0
			playParticleEffect()
			print("DEAD")
			isDead = true
			chroma_player.play("chroma")
			await get_tree().create_timer(0.1).timeout
			shockwave.play("shockwaveAnim")
		healthChanged.emit()
		
func instance_ghost():
	var ghost = ghost_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	
	ghost.global_position = global_position
	ghost.texture = sprite.texture
	ghost.rotation = rotation + PI/2
	ghost.scale = scale
	
	var ghost2 = ghost_scene2.instantiate()
	get_parent().get_parent().add_child(ghost2)
	
	ghost2.global_position = global_position
	ghost2.texture = sprite2.texture
	ghost2.rotation = rotation + PI/2
	ghost2.scale = scale


func _on_ghost_timer_timeout():
	instance_ghost()

func upgradeChecker():
	pass
	
func setHealth(newHealth:int):
	maxHealth = newHealth
	healthChanged.emit()

func setDamage(newDamage:int):
	damage = newDamage

func setSpeed(newSpeed:float):
	Speed = newSpeed

func setFireRate(newRate:float):
	fireCD = newRate
	
func setGuns():
	guns = true

func addGunsLVL3():
	pass

func addHealth(addHP:int):
	health += addHP
	healthChanged.emit()

func playParticleEffect():
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)

