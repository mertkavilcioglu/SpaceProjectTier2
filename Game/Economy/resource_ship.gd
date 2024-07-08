extends Node2D

var new_path:Path2D
var new_path_follow:PathFollow2D
var resource_ship_sprite:Sprite2D




func start_collecting(start_position:Vector2,destination_position:Vector2):
	new_path = Path2D.new()
	new_path_follow = PathFollow2D.new()
	new_path.curve = Curve2D.new()
	resource_ship_sprite = Sprite2D.new()
	
	add_child(new_path)
	new_path.add_child(new_path_follow)
	new_path_follow.add_child(resource_ship_sprite)
	
	resource_ship_sprite.texture = load("res://Sprites/uzaygemisi/resource ships/resource_ship.png")
	resource_ship_sprite.rotate(1.5)
	
	new_path.curve.add_point(start_position)
	new_path.curve.add_point(destination_position)
	new_path.curve.add_point(start_position)
	ratio = 0
var ratio = 0.0
func _process(delta):
	ratio += 0.1 * delta
	if new_path_follow:
		if ratio> 1:
			ratio = 0
		if ratio < 0.5:
			new_path_follow.progress_ratio = 0.25 - cos(2*PI*ratio)/4
		else:
			new_path_follow.progress_ratio = 0.75 + cos(2*PI*ratio)/4
		
		
	
