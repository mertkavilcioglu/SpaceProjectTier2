class_name EnemyHH
extends RigidBody2D

signal hit() 
var enemyHealth:int = 3 
var playerDamage:int = 1 

@onready var hulk = get_parent()
@export var deathParticle : PackedScene # ****** FOR EXPLOSION EFFECT ****** #
@export var playerRegen:int = 1


var laser_scene = preload("res://Game/Enemy/laser_enemy.tscn")
@onready var muzzle1=$Muzzle 
signal laser_shot(laser)
@onready var lasers=$"../Lasers"

@onready var hit_flash_anim_player = $HitFlashAnimationPlayer
@onready var muzzle_flash = $Muzzle/MuzzleFlashAnimationPlayer

func _physics_process(delta):
	look_at(hulk.player.position)
	
	
var shoot_bas=false

func _process(delta): 
	linear_velocity = hulk.linear_velocity
	if !shoot_bas:
		shoot_bas=true
		shoot_to_player()
		await get_tree().create_timer(1).timeout
		shoot_bas=false

func getHit(): 
	emit_signal("hit") 
	hit_flash_anim_player.play("hit_flash")
	if enemyHealth > 0: 
		enemyHealth -= hulk.player.damage 
	if enemyHealth <= 0:
		hulk.hunters -= 1
		if(hulk.player.health < hulk.player.maxHealth):
			hulk.player.health += playerRegen
		playParticleEffect()
		queue_free()
		
func shoot_to_player():
	var l = laser_scene.instantiate()
	lasers.add_child(l)
	l.global_position = muzzle1.global_position
	l.rotation = rotation + hulk.rotation + PI/2
	emit_signal("laser_shot", l)
	muzzle_flash.play("muzzle_flash_anim")
		
func playParticleEffect():
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	
