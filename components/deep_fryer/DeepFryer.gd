extends Node2D

var power: bool = true
var randomPowerFlicker: float

var heaterPowered: bool
var randomHeaterFlicker: float

func _ready():
	power = true
	randomPowerFlicker = float(20 + (randi() % 60))
	heaterPowered = true
	randomHeaterFlicker = float(60 + (randi() % 10))
	$OilIdle.play(randf() *6)
	
func _physics_process(delta):
	randomPowerFlicker -= delta
	if (randomPowerFlicker <= 0):
		if power:
			randomPowerFlicker = 0.30 + (randi() % 2) * 0.16
			power = false
			setPowerVis(false)
			setHeaterPowerVis(false)
		else:
			randomPowerFlicker = float(20 + (randi() % 60))
			power = true
			setPowerVis(true)
			if (heaterPowered):
				setHeaterPowerVis(true)
	
	if !power:
		return
		
	randomHeaterFlicker -= delta
	if (randomHeaterFlicker <= 0):
		if heaterPowered:
			randomHeaterFlicker = 5 + (randi() % 5)
			heaterPowered = false
			setHeaterPowerVis(false)
			
		else:
			randomHeaterFlicker = 10 + (randi() % 5)
			heaterPowered = true
			setHeaterPowerVis(true)
	
func setHeaterPowerVis(state: bool):
	$AudioRelay.play()
	$LightRed.visible = state
	
func setPowerVis(state: bool):
	$LightGreen.visible = state
	
	
	
