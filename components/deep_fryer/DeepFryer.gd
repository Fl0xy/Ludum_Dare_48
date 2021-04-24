extends Node2D

var power: bool = true
var randomPowerFlicker: float

var heaterPowered: bool = true
var randomHeaterFlicker: float

func _ready():
	randomPowerFlicker = float(15 + (randi() % 30))
	randomHeaterFlicker = float(60 + (randi() % 10))
	

func _physics_process(delta):
	randomPowerFlicker -= delta
	randomHeaterFlicker -= delta
	
	if (randomPowerFlicker <= 0):
		if power:
			randomPowerFlicker = 0.30 + (randi() % 3) * 0.16
			power = false
			$LightGreen.visible = false
			$LightRed.visible = false
		else:
			randomPowerFlicker = float(15 + (randi() % 30))
			power = true
			$LightGreen.visible = true
			if heaterPowered:
				$LightRed.visible = true
	
	if (randomHeaterFlicker <= 0):
		if heaterPowered:
			randomHeaterFlicker = 5 + (randi() % 5)
			heaterPowered = false
			$LightRed.visible = false
		else:
			randomHeaterFlicker = 10 + (randi() % 5)
			heaterPowered = true
			$LightRed.visible = true


