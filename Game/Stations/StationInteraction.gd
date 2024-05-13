extends Node2D
#Github
@onready var body_entered : bool = false
@onready var dialogue = $CanvasLayer
@onready var path_follow = $"../resource_ship/resource_ship_path/PathFollow2D"
@onready var resource_ship = $"../resource_ship/resource_ship_path/PathFollow2D/Sprite2D"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if body_entered == true:
		path_follow.progress += 70 * delta
		resource_ship.show()
		



func _on_area_2d_body_entered(body):
	if(body.name == "Character"):
		dialogue.show()
		body_entered = true
		#resource ship movement
		
		
