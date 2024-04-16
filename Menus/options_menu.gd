extends Control

const save_path = "user://game_save.save"

var HealthLevel:int
var SpeedLevel:int
var FuelLevel:int
var DamageLevel:int
var ScrapParts:int

func _ready():
	load_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")


func _on_reset_button_pressed():
	HealthLevel = 1
	SpeedLevel = 1
	FuelLevel = 1
	DamageLevel = 1
	ScrapParts = 10
	save_data()
	$HBoxContainer/VBoxContainer/Menu/VBoxContainer2/ResetButton.text = "Completed"

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(HealthLevel)
	file.store_var(SpeedLevel)
	file.store_var(FuelLevel)
	file.store_var(DamageLevel)
	file.store_var(ScrapParts)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		HealthLevel = file.get_var(HealthLevel)
		SpeedLevel = file.get_var(SpeedLevel)
		FuelLevel = file.get_var(FuelLevel)
		DamageLevel = file.get_var(DamageLevel)
		ScrapParts = file.get_var(ScrapParts)
	else:
		HealthLevel = 1
		SpeedLevel = 1
		FuelLevel = 1
		DamageLevel = 1
		ScrapParts = 0
