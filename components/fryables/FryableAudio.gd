extends Node2D

const OILSTOPWORKINGLENGTH = 11
var oilStartWorkingTime
var fryablesInside: int = 0
var insideOil: bool = false
var radomSkip: int
var destoryed: bool = false

signal finished

func _ready():
	get_parent().connect("oil_entered", self, "on_oil_entered")
	get_parent().connect("oil_exited", self, "on_oil_exited")
	get_parent().connect("degreeChanged", self, "play_sizzle")
	
	$Start.connect("finished", self, "on_Start_Finished")
	$Destory.connect("finished", self, "on_Destory_Finished")
	
func _physics_process(delta):
	if insideOil:
		if radomSkip == 0 && !destoryed:
			oilStartWorkingTime =  OS.get_unix_time()
			SoundDesync.resetLastPlayTime("start")
			$Start.pitch_scale = 1 - ((randf() - 0.5)  / 5)
			$Start.play()
		radomSkip -= 1
	
func destory():
	$Start.stop()
	$Working.stop()
	$Destory.pitch_scale = 1 - ((randf() - 0.5)  / 5)
	$Destory.play( (randi() % 30 + (30 - SoundDesync.lastPlayTime("destory"))) /100 )
	SoundDesync.resetLastPlayTime("destory")
	destoryed = true

func on_oil_entered():
	if !destoryed:
		radomSkip = randi() % 30 + (30 - SoundDesync.lastPlayTime("start"))
		insideOil = true

func on_oil_exited():
	if !destoryed:
		if $Start.playing:
			var skip = float( OILSTOPWORKINGLENGTH - (OS.get_unix_time() - oilStartWorkingTime)) +0.1
			$Start.stop()
			$Stop.play(skip)
		elif $Working.playing:
			$Working.stop()
			$Stop.play()
		insideOil = false

func on_Start_Finished():
	$Working.play()

func on_Destory_Finished():
	emit_signal("finished")

func play_sizzle():
	$Sizzle.play()
