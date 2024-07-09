extends Node2D


@onready var ship1 = $Path2D/ship1
@onready var ship2 = $Path2D2/ship2
@onready var ship3 = $Path2D3/ship3
@onready var ship4 = $Path2D4/ship4
@onready var ship5 = $Path2D5/ship5
@onready var ship6 = $Path2D6/ship6
@onready var ship7 = $Path2D7/ship7
var ships = []
var random_ratio = 0.00
var ratios = []
func _ready():
	ships.append(ship1)
	ships.append(ship2)
	ships.append(ship3)
	ships.append(ship4)
	ships.append(ship5)
	ships.append(ship6)
	ships.append(ship7)
	
	for i in range(7):
		ratios.append(randf_range(0.01,0.30))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	for i in range(len(ships)):
		ratios[i]+=delta*randf_range(0.01,0.1)
		if ratios[i]>1:
			ratios[i]=0
		ship_movement(ships[i],ratios[i])
		

func ship_movement(new_path_follow,ratio):
	if new_path_follow:
		if ratio> 1:
			ratio = 0
		if ratio < 0.5:
			new_path_follow.progress_ratio = 0.25 - cos(2*PI*ratio)/4
		else:
			new_path_follow.progress_ratio = 0.75 + cos(2*PI*ratio)/4
