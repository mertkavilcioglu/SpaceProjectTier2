class_name EnemyK
extends RigidBody2D 

signal hit() 
var enemyHealth:int = 3 
var playerDamage:int = 1 

@onready var player = get_parent().get_parent()
@export var enemyMaxSpeed: float = 900.0
@export var radius = 150
@export var deathParticle : PackedScene # ****** FOR EXPLOSION EFFECT ****** #
@export var playerRegen:int = 1

var distanceToPlayer_x:int
var distanceToPlayer_y:int
var calculatedRadius:int


@onready var hit_flash_anim_player = $HitFlashAnimationPlayer

func _physics_process(delta):
	look_at(player.position)
	
	
var shoot_bas=false

func _process(delta): 	
	var enemyMotion = Vector2()
	var position = global_position.direction_to(player.global_position) # Player'ın pozisyonunu alır
	
	linear_velocity = position * enemyMaxSpeed
	
	if(reachPlayerMidRadius()):
		player.playerGetHit(5)
		linear_velocity = Vector2.ZERO
		playParticleEffect()
		queue_free()

func getHit(): 
	emit_signal("hit") 
	hit_flash_anim_player.play("hit_flash_k")
	if enemyHealth > 0: 
		enemyHealth -= player.damage 
	if enemyHealth <= 0:
		if(player.health < player.maxHealth):
			player.addHealth(playerRegen)
		playParticleEffect()
		queue_free()
		
	
func reachPlayerMidRadius():
	distanceToPlayer_x = self.position.x - player.position.x
	distanceToPlayer_y = self.position.y - player.position.y
	
	calculatedRadius = int(sqrt(int(pow(distanceToPlayer_x,2)) + int(pow(distanceToPlayer_y,2)))) # c^2 = a^2 + b^2
	
	if(calculatedRadius <= radius): 
		return true
	else:
		return false
	
		
func playParticleEffect():
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	
