extends Node2D

var power: bool = true setget setPower
var randomPowerFlicker: float

var heaterPowered: bool setget setHeaterPower
var randomHeaterFlicker: float

func _ready():
	power = true
	randomPowerFlicker = float(15 + (randi() % 30))
	heaterPowered = true
	randomHeaterFlicker = float(60 + (randi() % 10))
	

func _physics_process(delta):
	randomPowerFlicker -= delta
	if (randomPowerFlicker <= 0):
		if power:
			randomPowerFlicker = 0.30 + (randi() % 3) * 0.16
			setPower(false)
		else:
			randomPowerFlicker = float(15 + (randi() % 30))
			setPower(true)
	
	if !power:
		return
		
	randomHeaterFlicker -= delta
	if (randomHeaterFlicker <= 0):
		if heaterPowered:
			randomHeaterFlicker = 5 + (randi() % 5)
			setHeaterPower(false)
			
		else:
			randomHeaterFlicker = 10 + (randi() % 5)
			setHeaterPower(true)
	
func setHeaterPower(state: bool):
	heaterPowered = state
	$AudioRelay.play()
	$LightRed.visible = state
	
func setPower(state: bool):
	power = state
	$LightGreen.visible = state
	setHeaterPower(state)
	
	
