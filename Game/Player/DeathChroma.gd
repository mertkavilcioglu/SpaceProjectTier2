extends ColorRect

@export var player: Player

func _ready():
	self.visible = false

func _process(delta):
	if(player.isDead):
		self.visible = true
