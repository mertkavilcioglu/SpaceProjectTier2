extends Node2D
#Github
@onready var body_entered : bool = false
@onready var dialogue = $CanvasLayer
@onready var dialogue_screen = $CanvasLayer/Dialogue
@onready var resource_ship = $"../resource_ship"
@onready var flag = true
@onready var game = $".."
@onready var character = $"../Character"
@export var station_id: String
var angle = 0.0
var safezone_bool = false
var dialogue_path:String
var text_id:String
var e_key_pressed_time = 0.0
const E_KEY_PRESS_DURATION = 2.0
@onready var e_interaction_sprite:Sprite2D
@onready var themis_safezone = $themis_safezone
@onready var karagunes_safezone = $karagunes_safezone
@onready var bgmusicchill = $"../Character/BGMusicChill"
@onready var bgmusicdanger = $"../Character/BGMusicDanger"
@onready var videoplayer = $"../Camera2D/CanvasLayer4/VideoStreamPlayer"
@onready var mission_vector = $"../mission_vector"
var video_flag = true
func _ready():
	
	
	e_interaction_sprite= Sprite2D.new()
	add_child(e_interaction_sprite)
	e_interaction_sprite.hide()
	
	
	if station_id == "1":
		karagunes_safezone.connect("body_entered",_on_safezone_body_entered)
		karagunes_safezone.connect("body_exited",_on_safezone_body_exited)
			
	elif station_id == "3":
		themis_safezone.connect("body_entered",_on_safezone_body_entered)
		themis_safezone.connect("body_exited",_on_safezone_body_exited)
		
		


func _process(delta):
	if dialogue_screen.nextdialogue == "1.1":
		dialogue_path = "res://Game/Player/texts/1.1.json"
		text_id = "iv1"
	elif dialogue_screen.nextdialogue == "1.2":
		dialogue_path = "res://Game/Player/texts/1.2.json"
		text_id = "text1"
	elif dialogue_screen.nextdialogue == "1.3":
		dialogue_path = "res://Game/Player/texts/1.3.json"
		text_id = "iv1"
	elif dialogue_screen.nextdialogue == "2.1":
		dialogue_path = "res://Game/Player/texts/2.1.json"
		text_id = "iv1"
	elif dialogue_screen.nextdialogue == "2.2":
		dialogue_path = "res://Game/Player/texts/2.2.json"
		text_id = "iv1"
	if station_id == "1":
		var shields = get_node("shields")
		shields.look_at(global_position)
		shields.rotation+= PI
		shields.global_position = global_position + Vector2(cos(angle), sin(angle)) * 100.0
	angle +=0.0002
	e_interaction_sprite.global_position = character.global_position + Vector2(60,-60)
	if videoplayer.isplaying == true:
		bgmusicchill.stop()
		bgmusicchill.stop()
	if dialogue_screen.missionvectorpath != null:
		mission_vector.station_changer(dialogue_screen.missionvectorpath)
	
	
	if videoplayer.isplaying and video_flag == false:
		dialogue.hide()
		video_flag = true
	elif !videoplayer.isplaying and video_flag == true:
		dialogue.show()
		video_flag = false
func _physics_process(delta):
	if body_entered:
		e_interaction_sprite.texture=load("res://Sprites/uı_elements/E_0.png")
		e_interaction_sprite.show()
		if Input.is_action_pressed("Interact"):
			if e_key_pressed_time >= 0 and e_key_pressed_time<=0.5:
				e_interaction_sprite.texture = load("res://Sprites/uı_elements/E_1.png")
			elif e_key_pressed_time >= 0.5 and e_key_pressed_time<=1:
				e_interaction_sprite.texture = load("res://Sprites/uı_elements/E_2.png")
			elif e_key_pressed_time >= 1 and e_key_pressed_time<=1.5:
				e_interaction_sprite.texture = load("res://Sprites/uı_elements/E_3.png")
			elif e_key_pressed_time >= 1.5 and e_key_pressed_time<=2:
				e_interaction_sprite.texture = load("res://Sprites/uı_elements/E_3_LightedUp.png")
			e_key_pressed_time += delta
			if character.enemy_nearby == false:
				if e_key_pressed_time >= E_KEY_PRESS_DURATION and character.on_dialogue == false:
						dialogue_screen.dialogue(dialogue_path,text_id)
						dialogue.show()
						character.canvaslayer.visible = false
						character.on_dialogue = true
					
		elif Input.is_action_just_released("Interact"):
			e_key_pressed_time = 0
				
	if !body_entered:
		dialogue.hide()
		e_interaction_sprite.hide()
	if character.on_dialogue == false:
		character.canvaslayer.visible = true
		

func _on_area_2d_body_entered(body):
	if body.name == "Character":
		body_entered = true
		e_key_pressed_time = 0.0 
		print("enter")


func _on_area_2d_body_exited(body):
	print("exit")
	if body.name == "Character":
		body_entered = false
		e_key_pressed_time = 0.0 


func _on_safezone_body_entered(body):
	if body.name == "Character":
		safezone_bool = true


func _on_safezone_body_exited(body):
	if body.name == "Character":
		safezone_bool = false

