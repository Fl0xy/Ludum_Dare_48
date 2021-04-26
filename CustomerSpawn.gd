tool
extends Position2D

var RandomCosumerScene = preload("res://components/costumer/Customer.tscn")
var activeCustomer = []

func nextCustomerRandom():
	nextCustomer(RandomCosumerScene.instance())

func nextCustomer(customer):
	activeCustomer.append(customer)
	$container.add_child(customer)
	customer.connect("orderDone", self, "on_customer_orderDone")
	$AnimationPlayer.play("enter")

func on_customer_orderDone():
	$AnimationPlayer.play("exit")
	
func _ready():
	for child in $container.get_children():
		child.queue_free()
	if Engine.is_editor_hint():
		nextCustomerRandom()
		get_child(0).set_owner(get_tree().edited_scene_root)
	else:
		OrderSystem.customerSpawn = self


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "exit":
		for child in $container.get_children():
			child.visible = false
