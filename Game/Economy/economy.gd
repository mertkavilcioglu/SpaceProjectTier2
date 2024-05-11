extends Node

const save_path = "user://game_save.save"

@export var OxygenDecayRate:int = 1

var Uranium:int
var ScrapMetal:int
var Soil:int
var Oxygen:int
var Soldier:int
var Worker:int
var Engineer:int

# Called when the node enters the scene tree for the first time.
func _ready():
	load_economy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_economy():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(Uranium)
	file.store_var(ScrapMetal)
	file.store_var(Soil)
	file.store_var(Oxygen)
	file.store_var(Soldier)
	file.store_var(Worker)
	file.store_var(Engineer)


func load_economy():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		Uranium = file.get_var(Uranium)
		ScrapMetal = file.get_var(ScrapMetal)
		Soil = file.get_var(Soil)
		Oxygen = file.get_var(Oxygen)
		Soldier = file.get_var(Soldier)
		Worker = file.get_var(Worker)
		Engineer = file.get_var(Engineer)
	else:
		Uranium = 0
		ScrapMetal = 0
		Soil = 0
		Oxygen = 100
		Soldier = 0
		Worker = 0
		Engineer = 0


func _on_decay_timer_timeout():
	Oxygen -= OxygenDecayRate
	save_economy()
