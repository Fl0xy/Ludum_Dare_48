extends Node2D

var RecipeScene = preload("res://components/recipe/Recipe.tscn")

func _enter_tree():
	OrderSystem.recipe_holder = self

func construct_recip(order : OrderSystem.Order):
	var recipe = RecipeScene.instance()
	var i = 1
	for point in order.order_points:
		# my gosh this would not be necessary if arrays in godot where more sensible ... or i might be brighter ...
		match i:
			1:
				recipe.fryable_1 = point.fryable
				recipe.frydegree_1 = point.frydegree
				recipe.amount_1 = point.amount-1
			2:
				recipe.fryable_2 = point.fryable
				recipe.frydegree_2 = point.frydegree
				recipe.amount_2 = point.amount-1
			3:
				recipe.fryable_3 = point.fryable
				recipe.frydegree_3 = point.frydegree
				recipe.amount_3 = point.amount-1
			4:
				recipe.fryable_4 = point.fryable
				recipe.frydegree_4 = point.frydegree
				recipe.amount_4 = point.amount-1
			5:
				recipe.fryable_5 = point.fryable
				recipe.frydegree_5 = point.frydegree
				recipe.amount_5 = point.amount-1
			6:
				recipe.fryable_6 = point.fryable
				recipe.frydegree_6 = point.frydegree
				recipe.amount_6 = point.amount-1
		
		i += 1
	
	return recipe
	

# returns false, if there is no place to put the recipe
func place_recip(order : OrderSystem.Order) -> bool:
	for c in get_children():
		if c.get_child_count() == 0:
			c.add_child(construct_recip(order))
			return true
	return false


func debug_ready():
	var point1 = OrderSystem.OrderPoint.new()
	point1.fryable = OrderSystem.fryables.fry
	point1.frydegree = OrderSystem.frydegrees.two
	point1.amount = 1
	
	var point2 = OrderSystem.OrderPoint.new()
	point2.fryable = OrderSystem.fryables.burger
	point2.frydegree = OrderSystem.frydegrees.three
	point2.amount = 5
	
	var order = OrderSystem.Order.new()
	order.order_points += [point1]
	order.order_points += [point2]
	
	print(place_recip(order))
	print(place_recip(order))
	print(place_recip(order))
	print(place_recip(order))
	print(place_recip(order))
	print(place_recip(order))
	print(place_recip(order))
	print(place_recip(order))
