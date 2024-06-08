extends ProgressBar

@export var player: Player

func _ready():
	player.boostFuelChanged.connect(update)
	update()
	
func update():
	value = player.BoostFuel
