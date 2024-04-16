extends Control

@onready var button = $MarginContainer/HBoxContainer/VBoxContainer/Button
@onready var credits_final = $MarginContainer/HBoxContainer/Panel2/CreditsFinal
@onready var credits = $MarginContainer/HBoxContainer/Panel2/Credits

@export var TextStartPos:float = 500
@export var TextEndPos:float = -950
@export var TextSpeed:float = 200

func _ready():
	button.grab_focus()
	credits_final.hide()
	credits.show()
	credits.global_position = Vector2(0, TextStartPos)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if credits.global_position.y > TextEndPos:
		credits.global_position.y -= TextSpeed * delta
	else:
		credits.hide()
		credits_final.show()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
