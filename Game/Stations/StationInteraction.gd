extends Node2D
#Github
@onready var body_entered : bool = false
@onready var dialogue = $CanvasLayer
@onready var dialogue_screen = $CanvasLayer/Dialogue
@onready var resource_ship = $"../resource_ship"
@onready var flag = true
@onready var game = $".."
@onready var character = $"../Character"
@export var station_id: int
var dialogue_path:String
var text_id:String
var e_key_pressed_time = 0.0
const E_KEY_PRESS_DURATION = 2.0

@onready var e_interaction_sprite:Sprite2D

func _ready():
	e_interaction_sprite= Sprite2D.new()
	add_child(e_interaction_sprite)
	e_interaction_sprite.hide()
	if station_id == 1:
		dialogue_path ="res://Game/DialogueSystem/mission_dialogues/mission1_part1.json"
		text_id = "text1"
	elif station_id == 2:
		dialogue_path = "res://Game/DialogueSystem/mission_dialogues/mission1_part2.json"
		text_id = "text17"
	elif station_id == 3:
		dialogue_path = "res://Game/DialogueSystem/mission_dialogues/mission1_part3.json"
		text_id ="text30"

func _process(delta):
	e_interaction_sprite.global_position = character.global_position + Vector2(60,-60)

func _physics_process(delta):
	if body_entered:
		e_interaction_sprite.texture=load("res://Sprites/uı_elements/E_0.png")
		e_interaction_sprite.show()
		if Input.is_action_pressed("Interact"):
			e_key_pressed_time += delta
			if character.enemy_nearby == false:
				if e_key_pressed_time >= 0.3 and e_key_pressed_time<0.7:
					e_interaction_sprite.texture = load("res://Sprites/uı_elements/E_1.png")
				elif e_key_pressed_time >= 0.7 and e_key_pressed_time<1.1:
					e_interaction_sprite.texture = load("res://Sprites/uı_elements/E_2.png")
				elif e_key_pressed_time >= 1.1 and e_key_pressed_time<1.5:
					e_interaction_sprite.texture = load("res://Sprites/uı_elements/E_3.png")
				elif  e_key_pressed_time >= 1.5:
					e_interaction_sprite.texture = load("res://Sprites/uı_elements/E_3_LightedUp.png")
				if e_key_pressed_time >= E_KEY_PRESS_DURATION and character.on_dialogue == false:
						dialogue_screen.dialogue(dialogue_path,text_id)
						dialogue.show()
						character.on_dialogue = true
		elif Input.is_action_just_released("Interact"):
			e_key_pressed_time = 0
		if flag:
			resource_ship.start_collecting(Vector2(570,122),Vector2(500,1000))
			flag = false
				
	if !body_entered:
		dialogue.hide()
		e_interaction_sprite.hide()
		

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


