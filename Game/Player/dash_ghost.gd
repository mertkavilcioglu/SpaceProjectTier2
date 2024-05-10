extends Sprite2D

var tween : Tween = Tween.new()

func _ready():
	tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",0.0,0.5)
