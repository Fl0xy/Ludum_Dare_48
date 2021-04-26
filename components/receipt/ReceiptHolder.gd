extends Node2D

const speedVector = Vector2(5,5)
var recieptDict = {}
var free1: bool = true
var free2: bool = true
var free3: bool = true


func _enter_tree():
	OrderSystem.recipe_holder = self
	
func _ready():
	pass

func addReciept(reciept: Recipe) -> bool:
	if recieptDict.size() > 3:
		return false
	
	if free1:
		$Animation1.play("Deploy")
		recieptDict[reciept] = $PegsOnString1/Position2D
		reciept.connect("destory", self, "on_Reciept_destory")
		free1 = false
		return true
	if free2:
		$Animation2.play("Deploy")
		recieptDict[reciept] = $PegsOnString2/Position2D
		reciept.connect("destory", self, "on_Reciept_destory")
		free2 = false
		return true
	if free3:
		$Animation3.play("Deploy")
		recieptDict[reciept] = $PegsOnString3/Position2D
		reciept.connect("destory", self, "on_Reciept_destory")
		free3 = false
		return true
	return false

func on_Reciept_destory(reciept):
	var slot = recieptDict[reciept]
	if slot == $PegsOnString1/Position2D:
		free1 = true
		$Animation1.play_backwards("Deploy")
	elif slot == $PegsOnString2/Position2D:
		free2 = true
		$Animation2.play_backwards("Deploy")
	elif slot == $PegsOnString3/Position2D:
		free3 = true
		$Animation3.play_backwards("Deploy")
	recieptDict.erase(reciept)
	
	
func _process(delta):
	var keys = recieptDict.keys()
	for key in keys:
		if !is_instance_valid(key):
			continue
		if key.held:
			continue
		var recieptPos = key.global_position
		var targetPos = recieptDict[key].global_position
		var diff = targetPos - recieptPos
		if (diff.abs() < speedVector.abs()):
			key.global_position = targetPos
			key.global_rotation_degrees = 0
			continue
		var multi = Vector2.ONE
		if diff.abs().x < diff.abs().y:
			multi.x = diff.abs().x/ diff.abs().y
		else:
			multi.y = diff.abs().y/diff.abs().x
		if diff.x < 1:
			multi.x *= -1
		if diff.y < 1:
			multi.y *= -1
		var move = speedVector * multi
		key.global_position = key.global_position + move
		
