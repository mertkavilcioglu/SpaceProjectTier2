extends Node2D

@onready var character = $"../Character"
var target_position
var distance_to_character

func _ready():
	if distance_to_character == 300:
		target_position = character.global_position

func _process(delta):
	distance_to_character = global_position.distance_to(character.global_position)
	if distance_to_character > 300:
		global_position = global_position.lerp(character.global_position,delta)
	elif distance_to_character == 300:
		global_position = global_position.lerp(target_position,delta)

