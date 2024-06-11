extends Node2D
#Github
@onready var body_entered : bool = false
@onready var dialogue = $CanvasLayer
@onready var dialogue_screen = $CanvasLayer/Dialogue
@onready var resource_ship = $"../resource_ship"
@onready var flag = true
@onready var character = $"../Character"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if dialogue_screen.character_on_dialogue == false and character.on_dialogue == true:
			print("abc")
			character.ondialogue(false)


func _on_area_2d_body_entered(body):
	if(body.name == "Character"):
		if flag:
			resource_ship.start_collecting(Vector2(570,122),Vector2(500,1000))
			dialogue_screen.dialogue("res://Game/DialogueSystem/mission_dialogues/mission1_part1.json","text1")
			dialogue.show()
			character.ondialogue(true)
			body_entered = true
			flag = false
		
		
		
