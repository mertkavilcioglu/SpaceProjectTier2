extends CanvasLayer

@onready var upgradeScreen = $"../CanvasLayer/UpgradeScreen"

@onready var scrapCont = $ScrapCont

func _process(delta):
	if upgradeScreen.highScore != null:
		$StatCont/HighScore/hsNumber.text = str(upgradeScreen.highScore)
	$StatCont/Waves/WaveNumber.text = str($"../EnemySpawnerSURVIVAL".currentWave)
	$ScrapCont/Parts.text = str(upgradeScreen.ScrapParts)
	
	if upgradeScreen.visible == true:
		scrapCont.visible = false
	
	if upgradeScreen.visible == false:
		scrapCont.visible = true
