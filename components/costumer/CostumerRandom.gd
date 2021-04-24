tool
extends Node2D

var hair: Sprite
var head: Sprite
var shirt: Sprite

func _ready():
	hair = HairList.hairList[randi() % HairList.hairList.size()].instance()
	head = HeadList.headList[randi() % HeadList.headList.size()].instance()
	shirt = ShirtList.shirtList[randi() % ShirtList.shirtList.size()].instance()
	
	var tmpHeight: int = 0
	add_child(shirt)
	tmpHeight -= 104
	head.set_position(Vector2(0, tmpHeight))
	add_child(head)
	tmpHeight -= 24
	hair.set_position(Vector2(0, tmpHeight))
	add_child(hair)
	

func _draw():
	if Engine.editor_hint:
		draw_rect(Rect2(-20,-40,40,40), Color.orange, false)
