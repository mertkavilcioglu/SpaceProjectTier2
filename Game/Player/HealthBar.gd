extends ProgressBar

@export var player: Player

func _ready():
	player.healthChanged.connect(update)
	update()
	
func update():
	value = player.health * 100 / player.maxHealth
