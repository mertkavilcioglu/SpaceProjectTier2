extends Control

@onready var player = get_parent().get_parent()
@onready var animPlayed = false;
func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	self.visible = false
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blurAnim")

func pause():
	self.visible = true
	get_tree().paused = true
	if(animPlayed == false):
		$AnimationPlayer.play("blurAnim")
		animPlayed = true
		player.DieSoundPlayer.play()

func testDeath():
	if (player.isDead) and !get_tree().paused:
		await get_tree().create_timer(1).timeout
		pause()


func _on_quit_pressed():
	resume()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _process(delta):
	testDeath()


func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()
