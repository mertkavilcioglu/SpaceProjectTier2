extends Node2D
#Github
@onready var body_entered : bool = false
@onready var dialogue = $CanvasLayer
@onready var dialogue_screen = $CanvasLayer/Dialogue
@onready var resource_ship = $"../resource_ship"
@onready var flag = true
@onready var game = $".."

var e_key_pressed_time = 0.0
const E_KEY_PRESS_DURATION = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if body_entered:
		if Input.is_action_pressed("Interact"):
			e_key_pressed_time += delta
			if e_key_pressed_time >= E_KEY_PRESS_DURATION:
				dialogue.show()
				
		if flag:
			resource_ship.start_collecting(Vector2(570,122),Vector2(500,1000))
			flag = false
				
	if !body_entered:
		dialogue.hide()
		

func _on_area_2d_body_entered(body):
	if body.name == "Character":
		body_entered = true
		e_key_pressed_time = 0.0 
		print("enter")


func _on_area_2d_body_exited(body):
	print("exit")
	if body.name == "Character":
		body_entered = false
		e_key_pressed_time = 0.0 


