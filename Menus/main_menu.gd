extends Control

@onready var play_button = $MarginContainer/VBoxContainer/PlayButton
@onready var karagünes = $"karagünes"

func _ready():
	play_button.grab_focus()
	
func _process(delta):
	if karagünes.scale > Vector2(0.05,0.05):
		karagünes.scale-=Vector2(0.00007,0.00007)


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Menus/options_menu.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Menus/credits.tscn")

func _on_quit_button_pressed():
	get_tree().quit()


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Game/game.tscn")


func _on_upgrade_button_pressed():
	get_tree().change_scene_to_file("res://Upgrade/upgrade.tscn")


func _on_play_survival_button_pressed():
	get_tree().change_scene_to_file("res://Game/survival.tscn")
