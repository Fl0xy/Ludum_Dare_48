extends Node2D

const OILSTOPWORKINGLENGTH = 11
var oilStartWorkingTime
var fryablesInside: int = 0
var insideOil: bool = false
var radomSkip: int

func _ready():
	get_parent().connect("oil_entered", self, "on_oil_entered")
	get_parent().connect("oil_exited", self, "on_oil_exited")
	
func _physics_process(delta):
	if insideOil:
		if radomSkip == 0 && !$OilStartWorking.playing:
			oilStartWorkingTime =  OS.get_unix_time()
			$OilStartWorking.play()
		elif radomSkip < 0 && !$OilStartWorking.playing&& !$OilWorking.playing:
			$OilWorking.play()
		radomSkip -= 1
	

func on_oil_entered():
	radomSkip = randi() % 10
	insideOil = true

func on_oil_exited():
	if $OilStartWorking.playing:
		var skip = float( OILSTOPWORKINGLENGTH - (OS.get_unix_time() - oilStartWorkingTime))
		$OilStartWorking.stop()
		$OilStopWorking.play(skip)
	else:
		$OilWorking.stop()
		$OilStopWorking.play()
	insideOil = false
