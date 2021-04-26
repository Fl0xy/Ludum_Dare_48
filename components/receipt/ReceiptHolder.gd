extends Node2D

var RecipeScene = preload("res://components/receipt/Receipt.tscn")

func _enter_tree():
	OrderSystem.recipe_holder = self
	
func _ready():
	$PegsOnString1.visible = false
	$PegsOnString2.visible = false
	$PegsOnString3.visible = false

func construct_receipt(order : Dtos.Order):
	var recipe = RecipeScene.instance()
	var i = 1
	for point in order.order_points:
		# my gosh this would not be necessary if arrays in godot where more sensible ... or i might be brighter ...
		match i:
			1:
				recipe.fryable_1 = point.fryable
				recipe.frydegree_1 = point.degree
				recipe.amount_1 = point.amount
			2:
				recipe.fryable_2 = point.fryable
				recipe.frydegree_2 = point.degree
				recipe.amount_2 = point.amount
			3:
				recipe.fryable_3 = point.fryable
				recipe.frydegree_3 = point.degree
				recipe.amount_3 = point.amount
			4:
				recipe.fryable_4 = point.fryable
				recipe.frydegree_4 = point.degree
				recipe.amount_4 = point.amount
			5:
				recipe.fryable_5 = point.fryable
				recipe.frydegree_5 = point.degree
				recipe.amount_5 = point.amount
			6:
				recipe.fryable_6 = point.fryable
				recipe.frydegree_6 = point.degree
				recipe.amount_6 = point.amount
		
		i += 1
	
	return recipe
	

# returns null, if there is no place to put the recipe
func place_receipt(order : Dtos.Order) -> Recipe:
	for c in get_children():
		if c.get_child(0).get_child_count() == 0:
			c.visible = true
			var receipt = construct_receipt(order)
			c.get_child(0).add_child(receipt)
			return receipt
	return null


func debug_ready():
	var point1 = OrderSystem.OrderPoint.new()
	point1.fryable = OrderSystem.fryables.fry
	point1.frydegree = OrderSystem.frydegrees.two
	point1.amount = 1
	
	var point2 = OrderSystem.OrderPoint.new()
	point2.fryable = OrderSystem.fryables.burger
	point2.frydegree = OrderSystem.frydegrees.three
	point2.amount = 4
	
	var order = OrderSystem.Order.new()
	order.order_points += [point1]
	order.order_points += [point2]
	
	print(place_receipt(order))
	print(place_receipt(order))
	print(place_receipt(order))
