extends Node

var RandomCosumerScene = preload("res://components/costumer/Customer.tscn")
var activeCustomer = []

func nextCustomer():
	var randomCosumer = RandomCosumerScene.instance()
	activeCustomer.append(randomCosumer)
	get_node("/root/Main/CustomerSpawn").add_child(randomCosumer)
