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
@export var Speed:float = 400
@export var MaxSpeed:float = Speed
@export var Acceleration:float = 4.3
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
@onready var enemy_alert = $"../Camera2D/CanvasLayer2/enemy_alert"
@onready var safezone_animation = $"../Camera2D/CanvasLayer3/station_area_animation"
var safezone = false

@onready var karagünes_atolyesi = $"../karagünes_atolyesi"
@onready var themis = $"../themis"
@onready var korsan_istasyonu = $"../korsan_istasyonu"
@onready var iroh = $"../iroh"
@onready var devrimci = $"../devrimci"

@onready var Engine1_red = $Engine1/Trail
@onready var Engine1_blue = $Engine1/TrailBlue
@onready var Engine2_red = $Engine2/Trail
@onready var Engine2_blue = $Engine2/TrailBlue

@onready var BGChillMusicPlayer =$BGMusicChill
@onready var BGDangerMusicPlayer = $BGMusicDanger
@onready var EngineSoundPlayer = $SoundEffects/EngineStart
@onready var ShootSoundPlayer = $SoundEffects/Shoot
@onready var DieSoundPlayer = $SoundEffects/Die
@onready var DashSoundPlayer = $SoundEffects/Dash
@onready var KillSoundPlayer = $SoundEffects/Kill

@onready var canvaslayer = $CanvasLayer
@onready var videoplayer = $"../Camera2D/CanvasLayer4/VideoStreamPlayer"

@onready var bbar = $CanvasLayer/BoostBar
@onready var hbar = $CanvasLayer/HealthBar
@onready var bbartexture = $CanvasLayer/energy_bar
@onready var hbartexture = $CanvasLayer/health_bar
@onready var colorrect = $"../Camera2D/CanvasLayer"
@onready var safezone_shader = $"../Camera2D/CanvasLayer3/safezone"
@onready var radar = $CanvasLayer/radar
@onready var radar_frame = $CanvasLayer/radar_frame

@onready var karagünes = $"../karagünes_atolyesi"


var isChillMusic:bool
var isDangerMusic:bool
var isEngineStart:bool




func _ready():
	radar.play()
	if get_tree().current_scene.name != "SurvivalGame":
		videoplayer.playvideo("res://Game/videos/intro (1).ogv")
	#if get_tree().current_scene.name != "SurvivalGame":
		#bgmusic()
	isEngineStart = false
	shockwave.play("RESET")
	chroma_player.play("RESET")
	shader_animation.play("RESET")
	boostFuelChanged.emit()
	healthChanged.emit()
	Engine1_red.visible = true
	Engine2_red.visible = true
	Engine1_blue.visible = false
	Engine2_blue.visible = false
	await get_tree().create_timer(0.11).timeout
	health = maxHealth
	

func _process(delta): 
	if videoplayer.isplaying == true:
		BGChillMusicPlayer.stop()
		BGChillMusicPlayer.stop()
	playCameraShakeEngineSound()
	if isChillMusic:
		BGChillMusicPlayer.volume_db = lerp(BGChillMusicPlayer.volume_db,-20.0,0.1*delta)
		BGDangerMusicPlayer.volume_db = lerp(BGDangerMusicPlayer.volume_db,-80.0,4*delta)
		if not BGChillMusicPlayer.playing:
			BGChillMusicPlayer.play()
			
	if isDangerMusic:
		BGChillMusicPlayer.volume_db = lerp(BGChillMusicPlayer.volume_db,-80.0,4*delta)
		BGDangerMusicPlayer.volume_db = lerp(BGDangerMusicPlayer.volume_db,-20.0,0.1*delta)
		if not BGDangerMusicPlayer.playing:
			BGDangerMusicPlayer.play()
	if enemy_nearby:
		if get_tree().current_scene.name != "SurvivalGame":
			isDangerMusic = true
			isChillMusic=false
	if !enemy_nearby:
		if get_tree().current_scene.name != "SurvivalGame":
			await get_tree().create_timer(2).timeout
			if !enemy_nearby:
				isChillMusic = true
				isDangerMusic=false
	if (!isDead):
		if (!on_dialogue):
			if !videoplayer.isplaying:
				upgradeChecker()
				if Input.is_action_pressed("Shoot"):
					if !shoot_bas:
						shoot_bas=true
						shoot_laser()
						await get_tree().create_timer(fireCD).timeout
						shoot_bas=false
	if is_enemy_nearby() == true and enemy_nearby== false:
		print("enemy nearby")
		shader_animation.play("enemy_nearby_true")
		print(enemy_nearby)
		enemy_nearby = true
		canvaslayer2.visible = true
	elif is_enemy_nearby() == false and enemy_nearby == true:
		shader_animation.play("enemy_nearby_false")
		print(enemy_nearby)
		enemy_nearby = false
		#canvaslayer2.visible = false

	if karagünes_atolyesi != null and themis != null:
		if karagünes_atolyesi.safezone_bool == true or themis.safezone_bool == true:
			if safezone == false:
				safezone_animation.play("safezone_true")
				safezone = true
		elif  karagünes_atolyesi.safezone_bool == false or themis.safezone_bool == false:
			if safezone == true:
				safezone = false
				safezone_animation.play("safezone_false")

		
func is_enemy_nearby() -> bool:
	for body in enemy_nearby_area.get_overlapping_bodies():
		if body is Enemy or body is EnemyH or body is EnemyHH or body is EnemyK:
			return true
			
	return false


func _physics_process(delta): 
	if(!isDead):
		if(!on_dialogue):
			if !videoplayer.isplaying:
				bbar.visible = true
				hbar.visible = true
				bbartexture.visible = true
				hbartexture.visible = true
				colorrect.visible = true
				radar.visible = true
				radar_frame.visible = true
				if safezone_shader != null:
					safezone_shader.visible = true
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
								if enemy_nearby:
									DashSoundPlayer.play()
									Engine1_red.visible = true
									Engine2_red.visible = true
									Engine1_blue.visible = false
									Engine2_blue.visible = false
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
								else:
									Engine1_red.visible = false
									Engine2_red.visible = false
									Engine1_blue.visible = true
									Engine2_blue.visible = true
									MaxSpeed = Speed*2
									BoostFuel -= 25*delta
									boostFuelChanged.emit()
						else:
							MaxSpeed = Speed
				else:
					MaxSpeed = Speed
					Engine1_red.visible = true
					Engine2_red.visible = true
					Engine1_blue.visible = false
					Engine2_blue.visible = false
					
					
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
			elif videoplayer.isplaying:
				bbar.visible = false
				hbar.visible = false
				bbartexture.visible = false
				hbartexture.visible = false
				colorrect.visible = false
				safezone_shader.visible = false
				radar.visible = false
				radar_frame.visible = false
		elif(on_dialogue):
			velocity.x = move_toward(velocity.x, 0 , Acceleration)
			velocity.y = move_toward(velocity.y, 0 , Acceleration)
	elif(isDead):
		velocity.x = move_toward(velocity.x, 0 , Acceleration)
		velocity.y = move_toward(velocity.y, 0 , Acceleration)
		move_and_slide()
		Cam.position = lerp(Cam.position, position, 5 * delta)
		if EngineSoundPlayer.playing: 
			EngineSoundPlayer.stop()
		if BGChillMusicPlayer.playing:
			BGChillMusicPlayer.stop()
		if BGDangerMusicPlayer.playing:
			BGDangerMusicPlayer.stop()
	
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
	ShootSoundPlayer.play()
	
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
	ghost.scale = scale*0.4
	



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
	
func setGuns(gunbool:bool):
	guns = gunbool

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

func playCameraShakeEngineSound():
	if isEngineStart == false:
		EngineSoundPlayer.play()
		isEngineStart = true;
	EngineSoundPlayer.volume_db = get_real_velocity().length() /25 - 50

func playKillSound():
	KillSoundPlayer.play()

