extends Control

@onready var player = get_parent().get_parent()
@onready var upgrade_screen = $"../UpgradeScreen"

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	self.visible = false
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blurAnim")

func pause():
	self.visible = true
	get_tree().paused = true
	$AnimationPlayer.play("blurAnim")

func testEsc():
	if(player.isDead == false):
		if Input.is_action_just_pressed("Pause") and !get_tree().paused:
			pause()
		elif Input.is_action_just_pressed("Pause") and get_tree().paused:
			resume()


func _on_resume_pressed():
	resume()


func _on_quit_pressed():
	resume()
	if get_tree().current_scene.name == "SurvivalGame":
		upgrade_screen.reset_upgrades()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _process(delta):
	testEsc()


func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()
