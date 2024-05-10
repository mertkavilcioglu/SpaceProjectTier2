class_name Player 
extends CharacterBody2D

#**************** UPGRADE VARIABLES *****************
var health:int = 10
var damage: int = 1
#var speed: float = 500.0
#var fuel: float = 100.0
@onready var body = $body
@onready var wing = $wing
@onready var LevelPanel = get_node("Upgrade/NewLevel")
var level_counter = 1

#**************** MOVEMENT-COMBAT VARIABLES and FUNCTIONS *****************

@export var MaxSpeed:float = 500.0
@export var Acceleration:float = 100.0
@onready var Cam = $"../Camera2D"
var MousePosition = null
@onready var CanBoost:bool = true
@onready var BoostRefuel:bool = false
@onready var BoostFuel:float = 100.0
@onready var muzzle1=$Muzzle 
@onready var muzzle2=$Muzzle2
@onready var muzzle3=$Muzzle3
@onready var lasers=$"../Lasers"

var laser_scene = preload("res://Game/Player/laser.tscn")
signal laser_shot(laser)
var BoostCD:int = 3
var shoot_bas=false

func _process(delta): 
	if Input.is_action_pressed("Shoot"):
		if !shoot_bas:
			shoot_bas=true
			shoot_laser()
			await get_tree().create_timer(0.5).timeout
			shoot_bas=false

func _physics_process(delta): 
	print(BoostFuel)
	if BoostFuel <100:
		BoostFuel += 10*delta
	
	var Motion = Vector2()
	Motion.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	Motion.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	velocity.x = move_toward(velocity.x, Motion.x * MaxSpeed , Acceleration)
	velocity.y = move_toward(velocity.y, Motion.y * MaxSpeed , Acceleration)
	
	if Input.is_action_pressed("Turbo"):
		if BoostRefuel == false:
			if BoostFuel <0:
				BoostRefuel = true
			if BoostFuel > 0:
				if CanBoost == true:
					MaxSpeed = 3000
					velocity.x = move_toward(velocity.x, Motion.x * MaxSpeed , Acceleration*100)
					velocity.y = move_toward(velocity.y, Motion.y * MaxSpeed , Acceleration*100)
					BoostFuel -= 20
					CanBoost = false
				elif CanBoost == false:
					MaxSpeed = 1500
					if BoostFuel > 0:
						BoostFuel -= 50*delta
					else: 
						MaxSpeed = 500
			else:
				MaxSpeed = 500
		elif BoostRefuel == true:
			if BoostFuel < 100:
				BoostFuel += 50*delta
			else:
				BoostRefuel = false
	else:
		MaxSpeed = 500
	if Input.is_action_just_released("Turbo"):
		if BoostFuel > 20:
			CanBoost = true

	move_and_slide()
	MousePosition = get_global_mouse_position()
	look_at(MousePosition)
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
	#var l2 = laser_scene.instantiate()
	#l2.global_position = muzzle2.global_position
	#l2.rotation = rotation + PI/2
	#emit_signal("laser_shot", l2)
	#var l3 = laser_scene.instantiate()
	#l3.global_position = muzzle3.global_position
	#l3.rotation = rotation + PI/2
	#emit_signal("laser_shot", l3)
	
	
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
	
func playerGetHit(): 
	emit_signal("hit") 
	if health > 1: 
		health -= 1 #
	elif health <= 1:
		print("DEAD")

