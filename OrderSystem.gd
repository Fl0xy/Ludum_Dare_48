extends Node

var recipe_holder # reference is set from the RecipHolder itself
var pendingOrders = []
var waiting: bool = false

signal orderFulfilled

func _ready():
	waitForNextCustomer()
	connect("orderFulfilled", self, "on_orderFulfilled")
	
func waitForNextCustomer():
	waiting = true
	var timer: SceneTreeTimer = get_tree().create_timer(2.0 + randi() % 20)
	timer.connect("timeout", self, "createNextCustomer")
	

func createNextCustomer():
	CustomerSystem.nextCustomer();
	if pendingOrders.size() < 2:
		waitForNextCustomer()
	else:
		waiting = false
		
func on_orderFulfilled():
	if !waiting:
		waitForNextCustomer()

func generateOrder(length:int, specialRef=null, specialDegress=0)-> Dtos.Order : 
	var order = Dtos.Order.new()
	for i in range(length):
		var orderPoint = Dtos.OrderPoint.new() 
		orderPoint.fryable = randi() % (Dtos.EFryables.size()-1)
		orderPoint.degree = 1 + randi() % 3
		orderPoint.amount = 1 + randi() % 5
		order.order_points.append(orderPoint)
		
	if specialRef != null:
		var specialOrder = Dtos.SpecialOrderPoint.new()
		specialOrder.special_ref = specialRef
		specialOrder.degree = specialDegress
		order.special = specialOrder
	
	return order

func addOrder(order: Dtos.Order):
	var scene = recipe_holder.place_receipt(order)
	order.receiptScene = scene
	pendingOrders.append(order)
	

func fulfillOrder(recipeScene, fryablesArray):
	var order = findOrder(recipeScene)
	
	var score = 0
	
	for orderPoint in order.order_points:
		for i in range(orderPoint.amount):
			if findAndDeleteFryable(orderPoint.fryable, orderPoint.degree, fryablesArray):
				score += 1
			else:
				score -= 1
	
	print(score)
	
	for fryable in fryablesArray:
		fryable.queue_free()
	recipeScene.queue_free()
	
	# TODO animation
	
	order.customerScene.queue_free()
	pendingOrders.erase(order)
	emit_signal("orderFulfill")


func findOrder(recipeScene)-> Dtos.Order:
	for order in pendingOrders:
		if order.receiptScene == recipeScene:
			return order
	return null
	
func findAndDeleteFryable(fryableType, degree, fryablesArray) -> bool:
	for fryable in fryablesArray:
		if fryable.type == fryableType and fryable.degree == degree:
			fryablesArray.erase(fryable)
			fryable.queue_free()
			return true
	return false
