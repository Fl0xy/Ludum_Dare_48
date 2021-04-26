tool
extends Node2D

export var body_scene : PackedScene = null
export var head_scene : PackedScene = null
export var front_hair_scene : PackedScene = null
export var back_hair_scene : PackedScene = null


var body = null
var head = null
var front_hair = null
var back_hair = null

var bodys = [
	preload("res://components/costumer/bodys/Body_1.tscn"),
	preload("res://components/costumer/bodys/Body_2.tscn"),
	preload("res://components/costumer/bodys/Body_3.tscn"),
	preload("res://components/costumer/bodys/Body_4.tscn"),
	preload("res://components/costumer/bodys/Body_5.tscn"),
	preload("res://components/costumer/bodys/Body_6.tscn"),
]
var heads = [
	preload("res://components/costumer/heads/Head_1.tscn"),
	preload("res://components/costumer/heads/Head_2.tscn"),
	preload("res://components/costumer/heads/Head_3.tscn"),
	preload("res://components/costumer/heads/Head_4.tscn"),
	preload("res://components/costumer/heads/Head_5.tscn"),
	preload("res://components/costumer/heads/Head_6.tscn"),
	preload("res://components/costumer/heads/Head_7.tscn"),
	preload("res://components/costumer/heads/Head_8.tscn"),
	preload("res://components/costumer/heads/Head_9.tscn"),
]
var front_hairs = [
	preload("res://components/costumer/front_hairs/Front_Hair.tscn"),
	preload("res://components/costumer/front_hairs/Front_Hair_1.tscn"),
	preload("res://components/costumer/front_hairs/Front_Hair_2.tscn"),
	preload("res://components/costumer/front_hairs/Front_Hair_3.tscn"),
	preload("res://components/costumer/front_hairs/Front_Hair_4.tscn"),
	preload("res://components/costumer/front_hairs/Front_Hair_5.tscn"),
	preload("res://components/costumer/front_hairs/Front_Hair_6.tscn"),
	preload("res://components/costumer/front_hairs/Front_Hair_7.tscn"),
]
var back_hairs = [
	preload("res://components/costumer/back_hairs/Back_Hair.tscn"),
	preload("res://components/costumer/back_hairs/Back_Hair_1.tscn"),
	preload("res://components/costumer/back_hairs/Back_Hair_2.tscn"),
	preload("res://components/costumer/back_hairs/Back_Hair_3.tscn"),
]

func _ready():
	randomize()
	if body_scene == null:
		body = bodys[randi() % bodys.size()].instance()
	else:
		body = body_scene.instance()
	
	if head_scene == null:
		head = heads[randi() % heads.size()].instance()
	else:
		head = head_scene.instance()
	
	if front_hair_scene == null:
		front_hair = front_hairs[randi() % front_hairs.size()].instance()
	else:
		front_hair = front_hair_scene.instance()
	
	if back_hair_scene == null:
		back_hair = back_hairs[randi() % back_hairs.size()].instance()
	else:
		back_hair = back_hair_scene.instance()
	
	
	add_child(back_hair)
	add_child(body)
	add_child(head)
	add_child(front_hair)
	
	head.position = body.get_node("Head").position
	back_hair.position = head.position + head.get_node("Hair").position
	front_hair.position = back_hair.position
	
	if !Engine.is_editor_hint():
		var timer: SceneTreeTimer = get_tree().create_timer(1.0)
		timer.connect("timeout", self, "makeOrder")
	
func makeOrder():
	var order: Dtos.Order = OrderSystem.generateOrder(1)
	order.customerScene = self
	OrderSystem.addOrder(order)
	var timer: SceneTreeTimer = get_tree().create_timer(3)
	timer.connect("timeout", self, "invisibleHelper")
	
func invisibleHelper():
	visible = false
	
func getHead():
	return head
func getFrontHair():
	return front_hair
func getBackHair():
	return back_hair
