tool
extends RigidBody2D
class_name Recipe

enum fryables { burger, fry, onion, tomato, special, none, random }

export(int) var amount_1 = 1 + randi() % 9
export(fryables) var fryable_1 = fryables.random
export(int) var frydegree_1 = 1 + randi() % 3

export(int) var amount_2 = 0
export(fryables) var fryable_2 = fryables.none
export(int) var frydegree_2 = 0

export(int) var amount_3 = 0
export(fryables) var fryable_3 = fryables.none
export(int) var frydegree_3 = 0

export(int) var amount_4 = 0
export(fryables) var fryable_4 = fryables.none
export(int) var frydegree_4 = 0

export(int) var amount_5 = 0
export(fryables) var fryable_5 = fryables.none
export(int) var frydegree_5 = 0

export(int) var amount_6 = 0
export(fryables) var fryable_6 = fryables.none
export(int) var frydegree_6 = 0

var size:int = 0
var held:bool = false
var offset:Vector2 = Vector2.ZERO

func addOrder(orderPoint: Dtos.OrderPoint):
	add_order_paper(orderPoint.amount, orderPoint.fryable, orderPoint.degree)
	
func addSpecial(specialOrderPoint: Dtos.SpecialOrderPoint):
	add_order_paper(0, fryables.special, specialOrderPoint.degree)

signal destory(node)

func add_order_paper(amount, fryable, frydegree):
	# check if all options are set
	if (amount == 0) or (fryable == fryables.none) or (frydegree == 0) or (size > 5):
		return
		
	var orderPaperNode = get_node("OrderPaper" + str(1 + size))
	var collPaperNode = get_node("CollisionShape" + str(1 + size))
	
	if fryable == fryables.random:
		fryable = randi() % (fryables.size()-2)
	
	orderPaperNode.amount = amount
	orderPaperNode.fryable = fryable
	orderPaperNode.fry_degree = frydegree
	
	orderPaperNode.visible = true
	collPaperNode.disabled = false
	
	size += 1


func _enter_tree():
	randomize()
	
	$OrderPaper1.visible = false
	$CollisionShape1.disabled = true
	$OrderPaper2.visible = false
	$CollisionShape2.disabled = true
	$OrderPaper3.visible = false
	$CollisionShape3.disabled = true
	$OrderPaper4.visible = false
	$CollisionShape4.disabled = true
	$OrderPaper5.visible = false
	$CollisionShape5.disabled = true
	$OrderPaper6.visible = false
	$CollisionShape6.disabled = true

	add_order_paper(amount_1, fryable_1, frydegree_1)
	add_order_paper(amount_2, fryable_2, frydegree_2)
	add_order_paper(amount_3, fryable_3, frydegree_3)
	add_order_paper(amount_4, fryable_4, frydegree_4)
	add_order_paper(amount_5, fryable_5, frydegree_5)
	add_order_paper(amount_6, fryable_6, frydegree_6)
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			offset = event.position-global_position
			mode = RigidBody2D.MODE_RIGID
			held = true
			
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held && !event.pressed:
			mode = RigidBody2D.MODE_STATIC
			held = false

func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position() - offset
		



func _on_Recipe_tree_exiting():
	emit_signal("destory", self)
