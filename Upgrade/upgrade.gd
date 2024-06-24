extends Node2D

const save_path = "user://game_save.save"

@onready var H_lvl_1 = $Health/VBoxContainer/HBoxContainer/Lvl1
@onready var H_lvl_2 = $Health/VBoxContainer/HBoxContainer/Lvl2
@onready var H_lvl_3 = $Health/VBoxContainer/HBoxContainer/Lvl3
@onready var H_lvl_4 = $Health/VBoxContainer/HBoxContainer/Lvl4
@onready var H_lvl_5 = $Health/VBoxContainer/HBoxContainer/Lvl5

@onready var S_lvl_1 = $Speed/VBoxContainer/HBoxContainer/Lvl1
@onready var S_lvl_2 = $Speed/VBoxContainer/HBoxContainer/Lvl2
@onready var S_lvl_3 = $Speed/VBoxContainer/HBoxContainer/Lvl3
@onready var S_lvl_4 = $Speed/VBoxContainer/HBoxContainer/Lvl4
@onready var S_lvl_5 = $Speed/VBoxContainer/HBoxContainer/Lvl5

@onready var F_lvl_1 = $Fuel/VBoxContainer/HBoxContainer/Lvl1
@onready var F_lvl_2 = $Fuel/VBoxContainer/HBoxContainer/Lvl2
@onready var F_lvl_3 = $Fuel/VBoxContainer/HBoxContainer/Lvl3
@onready var F_lvl_4 = $Fuel/VBoxContainer/HBoxContainer/Lvl4
@onready var F_lvl_5 = $Fuel/VBoxContainer/HBoxContainer/Lvl5

@onready var D_lvl_1 = $Damage/VBoxContainer/HBoxContainer/Lvl1
@onready var D_lvl_2 = $Damage/VBoxContainer/HBoxContainer/Lvl2
@onready var D_lvl_3 = $Damage/VBoxContainer/HBoxContainer/Lvl3
@onready var D_lvl_4 = $Damage/VBoxContainer/HBoxContainer/Lvl4
@onready var D_lvl_5 = $Damage/VBoxContainer/HBoxContainer/Lvl5

@onready var ship_body = $BodyLvl1
@onready var ship_wing = $WingLvl1


var HealthLevel:int = 1
var SpeedLevel:int = 1
var FuelLevel:int = 1
var DamageLevel:int = 1
var ScrapParts:int = 0
var highScore:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	save_data()
	load_data()
	changeTextures()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	
func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Game/game.tscn")


func _on_health_upgrade_button_pressed():
	if ScrapParts > 0 and HealthLevel < 6:
		HealthLevel += 1
		ScrapParts-=1
	changeTextures()
	save_data()


func _on_speed_upgrade_button_pressed():
	if ScrapParts > 0 and SpeedLevel < 6:
		SpeedLevel += 1
		ScrapParts-=1
	changeTextures()
	save_data()


func _on_fuel_upgrade_button_pressed():
	if ScrapParts > 0 and FuelLevel < 6:
		FuelLevel += 1
		ScrapParts-=1
	changeTextures()
	save_data()


func _on_damage_upgrade_button_pressed():
	if ScrapParts > 0 and DamageLevel < 6:
		DamageLevel += 1
		ScrapParts-=1
	changeTextures()
	save_data()


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
		highScore = file.get_var(highScore)
	else:
		HealthLevel = 1
		SpeedLevel = 1
		FuelLevel = 1
		DamageLevel = 1
		ScrapParts = 1
		highScore = 0

func changeTextures():
	$HBoxContainer/Parts.text = str(ScrapParts)
	
	if HealthLevel == 1:
		ship_body.texture = load("res://Sprites/uzaygemisi/Bodies/Body_lvl1.png")
		H_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
	if HealthLevel == 2:
		ship_body.texture = load("res://Sprites/uzaygemisi/Bodies/Body_lvl2.png")
		H_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		H_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
	if HealthLevel == 3:
		ship_body.texture = load("res://Sprites/uzaygemisi/Bodies/Body_lvl3.png")
		H_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		H_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		H_lvl_3. texture = load("res://Sprites/UpgradeFilled.png")
	if HealthLevel == 4:
		ship_body.texture = load("res://Sprites/uzaygemisi/Bodies/Body_lvl4.png")
		H_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		H_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		H_lvl_3. texture = load("res://Sprites/UpgradeFilled.png")
		H_lvl_4.texture = load("res://Sprites/UpgradeFilled.png")
	if HealthLevel == 5:
		ship_body.texture = load("res://Sprites/uzaygemisi/Bodies/Body_lvl5.png")
		H_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		H_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		H_lvl_3. texture = load("res://Sprites/UpgradeFilled.png")
		H_lvl_4.texture = load("res://Sprites/UpgradeFilled.png")
		H_lvl_5.texture = load("res://Sprites/UpgradeFilled.png")
		
	if HealthLevel > 5:
		HealthLevel = 5
	
	if SpeedLevel == 1:
		if HealthLevel <= 1:
			ship_wing.texture = load("res://Sprites/uzaygemisi/Wings/Wing_lvl1.png")
		else:
			ship_wing.texture = load("res://Sprites/uzaygemisi/Wings/Wing_lvl1.png")
		S_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
	if SpeedLevel == 2:
		if HealthLevel <= 1:
			ship_wing.texture = load("res://Sprites/uzaygemisi/Wings/wing_lvl_2_body_lvl1.png")
		else:
			ship_wing.texture = load("res://Sprites/uzaygemisi/Wings/kanat lvl2.png")
		S_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		S_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
	if SpeedLevel == 3:
		if HealthLevel <= 1:
			ship_wing.texture = load("res://Sprites/uzaygemisi/Wings/wing_lvl3_body_lvl1.png")
		else:
			ship_wing.texture = load("res://Sprites/uzaygemisi/Wings/kanat lvl3.png")
		S_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		S_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		S_lvl_3.texture = load("res://Sprites/UpgradeFilled.png")
	if SpeedLevel == 4:
		if HealthLevel <= 1:
			ship_wing.texture = load("res://Sprites/uzaygemisi/Wings/wing_lvl4_body_lvl1.png")
		else:
			ship_wing.texture = load("res://Sprites/uzaygemisi/Wings/kanat lvl4.png")
		S_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		S_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		S_lvl_3.texture = load("res://Sprites/UpgradeFilled.png")
		S_lvl_4.texture = load("res://Sprites/UpgradeFilled.png")
	if SpeedLevel == 5:
		if HealthLevel <= 1:
			ship_wing.texture = load("res://Sprites/uzaygemisi/Wings/wing_lvl5_body_lvl1.png")
		else:
			ship_wing.texture = load("res://Sprites/uzaygemisi/Wings/kanat lvl5.png")
		S_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		S_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		S_lvl_3.texture = load("res://Sprites/UpgradeFilled.png")
		S_lvl_4.texture = load("res://Sprites/UpgradeFilled.png")
		S_lvl_5.texture = load("res://Sprites/UpgradeFilled.png")
	if SpeedLevel > 5:
		SpeedLevel = 5
	
	if FuelLevel == 1:
		F_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
	if FuelLevel == 2:
		F_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		F_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
	if FuelLevel == 3:
		F_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		F_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		F_lvl_3.texture = load("res://Sprites/UpgradeFilled.png")
	if FuelLevel == 4:
		F_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		F_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		F_lvl_3.texture = load("res://Sprites/UpgradeFilled.png")
		F_lvl_4.texture = load("res://Sprites/UpgradeFilled.png")
	if FuelLevel == 5:
		F_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		F_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		F_lvl_3.texture = load("res://Sprites/UpgradeFilled.png")
		F_lvl_4.texture = load("res://Sprites/UpgradeFilled.png")
		F_lvl_5.texture = load("res://Sprites/UpgradeFilled.png")
	if FuelLevel > 5:
		FuelLevel = 5
	
	if DamageLevel == 1:
		D_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
	if DamageLevel == 2:
		D_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		D_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
	if DamageLevel == 3:
		D_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		D_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		D_lvl_3.texture = load("res://Sprites/UpgradeFilled.png")
	if DamageLevel == 4:
		D_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		D_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		D_lvl_3.texture = load("res://Sprites/UpgradeFilled.png")
		D_lvl_4.texture = load("res://Sprites/UpgradeFilled.png")
	if DamageLevel == 5:
		D_lvl_1.texture = load("res://Sprites/UpgradeFilled.png")
		D_lvl_2.texture = load("res://Sprites/UpgradeFilled.png")
		D_lvl_3.texture = load("res://Sprites/UpgradeFilled.png")
		D_lvl_4.texture = load("res://Sprites/UpgradeFilled.png")
		D_lvl_5.texture = load("res://Sprites/UpgradeFilled.png")
	if DamageLevel > 5:
		DamageLevel = 5
