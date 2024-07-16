extends Node2D

@export var card_image : Sprite2D
@export var profile_image : Sprite2D
@export var right_text : RichTextLabel
@export var left_text : RichTextLabel
@export var dialogue_text : RichTextLabel
@export var monologue_text : RichTextLabel
@onready var station = get_parent().get_parent()
@onready var card_animation = $card_animation
@onready var monologue_animation = $monologue_animation
@onready var left_button = $card_image/select_left
@onready var right_button = $card_image/select_right
@onready var cinematic_video = $card_image/cinematic_video
var character_on_dialogue = false
var dialogues
var current_dialogue
var text_anim_timer
var text_order_flag = false

func _ready():
	position = get_viewport_rect().size/2
	text_anim_timer = Timer.new()
	add_child(text_anim_timer)
	text_anim_timer.wait_time = 0.03
	text_anim_timer.timeout.connect(text_)

func _process(delta):
	if visible == true:
		character_on_dialogue = true
		left_button.disabled = false
		right_button.disabled = false
		
		
func dialogue(dialogue_path,text_name):
	dialogues = load_dialogue(dialogue_path)
	current_dialogue =  dialogues[text_name]
	update_card()
	card_animation.play("card_animation")

	
func load_dialogue(file_path:String):
	var data_file = FileAccess.open(file_path , FileAccess.READ)
	var parsed = JSON.parse_string(data_file.get_as_text())
	return parsed
	
func update_card():
	right_text.text = current_dialogue["right_answer"]
	left_text.text = current_dialogue["left_answer"]
	dialogue_text.text = current_dialogue["question"]
	monologue_text.text = current_dialogue["monologue"]
	card_image.texture = load(current_dialogue["card_image"])
	profile_image.texture = load(current_dialogue["profile_image"])
	text_order_flag = false
	if current_dialogue["order"] == "d":
		text_anim_timer.start()
	if current_dialogue["order"] == "m":
		monologue_animation.stop()
		monologue_animation.play("monologue_animation_true")
	if current_dialogue["video"] == "true":
		cinematic_video.visible = true
		cinematic_video.play()

func select_left():
	if "left_result" in current_dialogue and current_dialogue["left_result"] !="null":
		if current_dialogue["order"] == "d":
			if text_order_flag == false:
				text_order_flag = true
				dialogue_text.visible_characters = -1
				text_anim_timer.stop()
				monologue_animation.play("monologue_animation_true")
			elif text_order_flag == true:
				text_order_flag = false
				current_dialogue = dialogues[current_dialogue["left_result"]]
				monologue_animation.stop()
				update_card()
				dialogue_text.visible_characters=0
		elif current_dialogue["order"] =="m":
			if text_order_flag == false:
				text_order_flag = true
				dialogue_text.visible_characters = 0
				text_anim_timer.start()
			elif text_order_flag == true:
				text_order_flag == false
				dialogue_text.visible_characters=0
				monologue_animation.stop()
				current_dialogue = dialogues[current_dialogue["left_result"]]
				update_card()
				
	elif "left_result" not in current_dialogue:
		if left_button.disabled == false:
			card_animation.play_backwards("card_animation")
		character_on_dialogue = false
		station.character.on_dialogue = false
		left_button.disabled = true
	
func select_right():
	if "right_result" in current_dialogue and current_dialogue["right_result"] !="null":
		if current_dialogue["order"] == "d":
			if text_order_flag == false:
				text_order_flag = true
				dialogue_text.visible_characters = -1
				text_anim_timer.stop()
				monologue_animation.play("monologue_animation_true")
			elif text_order_flag == true:
				text_order_flag = false
				current_dialogue = dialogues[current_dialogue["right_result"]]
				monologue_animation.stop()
				update_card()
				dialogue_text.visible_characters=0
		elif current_dialogue["order"] == "m":
			if text_order_flag == false:
				text_order_flag = true
				dialogue_text.visible_characters = 0
				text_anim_timer.start()
			elif text_order_flag == true:
				text_order_flag == false
				dialogue_text.visible_characters=0
				monologue_animation.stop()
				current_dialogue = dialogues[current_dialogue["right_result"]]
				update_card()
	elif "right_result" not in current_dialogue:
		if right_button.disabled == false:
			card_animation.play_backwards("card_animation")
			character_on_dialogue = false
			station.character.on_dialogue = false
			right_button.disabled = true

func text_():
	dialogue_text.visible_characters+=1
