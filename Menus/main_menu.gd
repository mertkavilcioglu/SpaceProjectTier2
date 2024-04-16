extends Control

@onready var play_button = $MarginContainer/VBoxContainer/PlayButton

func _ready():
	play_button.grab_focus()


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
