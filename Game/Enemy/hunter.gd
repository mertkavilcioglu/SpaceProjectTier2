class_name Enemy 
extends RigidBody2D

signal hit() 
var enemyHealth:int = 3 
var playerDamage:int = 1 

@onready var player = $"../Character"
@export var enemyMaxSpeed: float = 400.0
@export var radius = 200

var distanceToPlayer_x:int
var distanceToPlayer_y:int
var calculatedRadius:int

var laser_scene = preload("res://Game/Enemy/laser_enemy.tscn")
@onready var muzzle1=$Muzzle 
signal laser_shot(laser)
@onready var lasers=$"../Lasers"


func _physics_process(delta):
	look_at(player.position)
	
	
var shoot_bas=false

func _process(delta): 
	if !shoot_bas:
		shoot_bas=true
		shoot_to_player()
		await get_tree().create_timer(0.5).timeout
		shoot_bas=false
		
	var enemyMotion = Vector2()
	var position = global_position.direction_to(player.global_position) # Player'ın pozisyonunu alır
	
	linear_velocity = position * enemyMaxSpeed
	
	if(reachPlayerMidRadius()):
		print(calculatedRadius)
		linear_velocity = Vector2.ZERO

func getHit(): 
	emit_signal("hit") 
	if enemyHealth > 1: 
		enemyHealth -= 1 #
	elif enemyHealth <= 1:
		queue_free()
		
func shoot_to_player():
	var l = laser_scene.instantiate()
	lasers.add_child(l)
	l.global_position = muzzle1.global_position
	l.rotation = rotation + PI/2
	emit_signal("laser_shot", l)
	
	
func reachPlayerMidRadius():
	distanceToPlayer_x = self.position.x - player.position.x
	distanceToPlayer_y = self.position.y - player.position.y
	
	calculatedRadius = int(sqrt(int(pow(distanceToPlayer_x,2)) + int(pow(distanceToPlayer_y,2)))) # c^2 = a^2 + b^2
	
	if(calculatedRadius <= radius): 
		return true
	else:
		return false
	
		
