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
	preload("res://components/costumer/bodys/Body_1.tscn")
]
var heads = [
	preload("res://components/costumer/heads/Head_1.tscn")
]
var front_hairs = [
	preload("res://components/costumer/back_hairs/Back_Hair.tscn")
]
var back_hairs = [
	preload("res://components/costumer/front_hairs/Front_Hair.tscn")
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
	
	add_child(body)
	add_child(back_hair)
	add_child(head)
	add_child(front_hair)
	
	head.position = body.get_node("Head").position
	back_hair.position = head.position + head.get_node("Hair").position
	front_hair.position = back_hair.position
