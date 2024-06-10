extends Node2D
#Github
@onready var body_entered : bool = false
@onready var dialogue = $CanvasLayer
@onready var dialogue_screen = $CanvasLayer/Dialogue
@onready var resource_ship = $"../resource_ship"
@onready var flag = true
@onready var game = $".."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_area_2d_body_entered(body):
	if(body.name == "Character"):
		dialogue.show()
		body_entered = true
		if flag:
			resource_ship.start_collecting(Vector2(570,122),Vector2(500,1000))
			flag = false
		
		
		
