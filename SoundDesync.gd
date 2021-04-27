extends Node

var dict = {}

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var keys = dict.keys()
	for key in keys:
		dict[key] += 1

func lastPlayTime(key) -> int:
	if dict.has(key):
		if dict[key] > 30:
			return 30
		return dict[key]
	return 30

func resetLastPlayTime(key):
	dict[key] = 0
