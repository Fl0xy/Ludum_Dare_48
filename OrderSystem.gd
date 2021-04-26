extends Node

var recipe_holder # reference is set from the RecipHolder itself
var emote
var customerSpawn

var pendingOrders = []
var waiting: bool = false
var sucessfullOrders: int = 0

#VIPs
var agent47Scene = preload("res://components/costumer/agent47.tscn")
var agent47Done: bool = false
var gangsterScene = preload("res://components/costumer/gangster.tscn")
var gangsterDone: bool = false

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
	
	#VIPs
	#gangster
	if (sucessfullOrders > 10 && !gangsterDone):
		customerSpawn.nextCustomer(gangsterScene.instance())
		gangsterDone = true
	#agent47
	elif (sucessfullOrders > 20 && !agent47Done):
		customerSpawn.nextCustomer(agent47Scene.instance())
		agent47Done = true
	else:
		customerSpawn.nextCustomerRandom()
		
		
	if pendingOrders.size() < 2:
		waitForNextCustomer()
	else:
		print("Orders full -> wait for free")
		waiting = false
		
func on_orderFulfilled():
	if !waiting:
		print("order removed ", pendingOrders.size())
		waitForNextCustomer()

func addOrder(costumer, specialRef=null, specialDegress=0): 
	var order = Dtos.Order.new()
	order.customerScene = costumer
	
	var orderCount = 1
	if sucessfullOrders > 10:
		orderCount += 1
	if sucessfullOrders > 20:
		orderCount += 1
	if sucessfullOrders > 30:
		orderCount += 1
	if sucessfullOrders > 40:
		orderCount += 1
	
	var maxAmout = 1
	if sucessfullOrders > 1:
		maxAmout += 2
	if sucessfullOrders > 5:
		maxAmout += 2
	if sucessfullOrders > 20:
		maxAmout += 2
	if sucessfullOrders > 40:
		maxAmout += 2
	if sucessfullOrders > 60:
		maxAmout += 1
	
	if specialRef != null:
		var specialOrder = Dtos.SpecialOrderPoint.new()
		specialOrder.special_ref = specialRef
		specialOrder.degree = specialDegress
		order.special = specialOrder
		orderCount -= 1
	
	for i in range(orderCount):
		var orderPoint = Dtos.OrderPoint.new() 
		orderPoint.fryable = randi() % (Dtos.EFryables.size()-1)
		orderPoint.degree = 1 + randi() % 3
		orderPoint.amount = 1 + randi() % maxAmout
		order.order_points.append(orderPoint)
	
	if recipe_holder == null:
		return
	var scene = ReceiptFactory.construct_receipt(order)
	scene.visible = false
	get_node("/root/Main").add_child(scene)
	get_node("/root/Main/SpeechBubble").showReciept(scene)
	if order.special != null:
		order.special.special_ref.position = get_node("/root/Main/SpecialSpawner").global_position
		get_node("/root/Main").add_child(order.special.special_ref)
		order.special.special_ref.mode = RigidBody2D.MODE_STATIC
	#recipe_holder.place_receipt(order)
	order.receiptScene = scene
	pendingOrders.append(order)

func fulfillOrder(recipeScene, fryablesArray):
	var order: Dtos.Order = findOrder(recipeScene)
	
	var score = 0
	
	for orderPoint in order.order_points:
		for i in range(orderPoint.amount):
			if findAndDeleteFryable(orderPoint.fryable, orderPoint.degree, fryablesArray):
				score += 1
			else:
				score -= 1
				
	if order.special != null:
		if order.special.degree == 4:
			if order.special.special_ref.degree == 4:
				score += 100
			else:
				score -= 100
			order.special.special_ref.queue_free()
		else:
			if findAndDeleteFryable(order.special.special_ref.type, order.special.degree, fryablesArray):
				score += 100
			else:
				score -= 100
			
	order.score = score
	if score > 0:
		sucessfullOrders += 1
	
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
