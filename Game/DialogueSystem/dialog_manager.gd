extends Node

@export var card_image : Sprite2D
@export var profile_image : Sprite2D
@export var right_text : RichTextLabel
@export var left_text : RichTextLabel
@export var dialogue_text : RichTextLabel


var dialogues
var current_dialogue

func _ready():
	dialogues = load_dialogue("res://Game/DialogueSystem/Dialogues.json")
	current_dialogue =  dialogues["first_question"]
	update_card()

func load_dialogue(file_path:String):
	var data_file = FileAccess.open(file_path , FileAccess.READ)
	var parsed = JSON.parse_string(data_file.get_as_text())
	return parsed
	
func select_left():
	if "left_result" in current_dialogue:
		current_dialogue = dialogues[current_dialogue["left_result"]]
	update_card()
func select_right():
	if "right_result" in current_dialogue:
		current_dialogue = dialogues[current_dialogue["right_result"]]
	update_card()

func update_card():
	right_text.text = current_dialogue["right_answer"]
	left_text.text = current_dialogue["left_answer"]
	dialogue_text.text = current_dialogue["question"]
	card_image.texture = load(current_dialogue["card_image"])
	profile_image.texture = load(current_dialogue["profile_image"])
	

