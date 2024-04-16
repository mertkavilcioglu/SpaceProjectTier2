extends Line2D
class_name Trails

var queue : Array
@export var MAX_LENGTH : int

func _ready():
	queue = []
	set_process(true)

func _physics_process(delta): 
	var pos = get_parent().get_global_transform().origin
	queue.push_front(pos)
	if queue.size() > MAX_LENGTH:
		queue.pop_back()
	clear_points()
	for point in queue:
		add_point(point)
