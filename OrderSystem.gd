extends Node

var recipe_holder # reference is set from the RecipHolder itself
var emote
var customerSpawn

var pendingOrders = []
var waiting: bool = false

signal orderFulfilled

func _ready():
	connect("orderFulfilled", self, "on_orderFulfilled")
	call_deferred("createNextCustomer")
	
func waitForNextCustomer():
	print("Push next customer")
	waiting = true
	var timer: SceneTreeTimer = get_tree().create_timer(10.0 + randi() % 20)
	timer.connect("timeout", self, "createNextCustomer")
	

func createNextCustomer():
	print("next customer")
	customerSpawn.nextCustomer();
	if pendingOrders.size() < 2:
		waitForNextCustomer()
	else:
		print("Orders full -> wait for free")
		waiting = false
		
func on_orderFulfilled():
	if !waiting:
		print("order removed ", pendingOrders.size())
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
	if recipe_holder == null: return
	var scene = ReceiptFactory.construct_receipt(order)
	scene.visible = false
	get_node("/root/Main").add_child(scene)
	get_node("/root/Main/SpeechBubble").showReciept(scene)
	#recipe_holder.place_receipt(order)
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
	
	order.score = score
	print(score)
	
	for fryable in fryablesArray:
		fryable.queue_free()
	recipeScene.queue_free()
	
	emote.playEmote(order)
	
	pendingOrders.erase(order)
	emit_signal("orderFulfilled")


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
