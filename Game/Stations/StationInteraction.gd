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

func _ready():
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
	if character.on_dialogue == true and dialogue_screen.character_on_dialogue == false:
		character.on_dialogue = false

func _physics_process(delta):
	if body_entered:
		if Input.is_action_pressed("Interact"):
			e_key_pressed_time += delta
			if e_key_pressed_time >= E_KEY_PRESS_DURATION:
				if character.enemy_nearby == false:
					print("can open dialogue")
					dialogue_screen.dialogue(dialogue_path,text_id)
					dialogue.show()
					character.on_dialogue = true
				else:
					print("cannot open dialogue")	
		if flag:
			resource_ship.start_collecting(Vector2(570,122),Vector2(500,1000))
			flag = false
				
	if !body_entered:
		dialogue.hide()
		

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


