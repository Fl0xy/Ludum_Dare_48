tool
extends Position2D

var RandomCosumerScene = preload("res://components/costumer/Customer.tscn")
var activeCustomer = []

func nextCustomer():
	var randomCosumer = RandomCosumerScene.instance()
	activeCustomer.append(randomCosumer)
	add_child(randomCosumer)
	
func _ready():
	for child in get_children():
		child.queue_free()
	if Engine.is_editor_hint():
		nextCustomer()
		get_child(0).set_owner(get_tree().edited_scene_root)
	else:
		OrderSystem.customerSpawn = self
