extends Node

const RecipeScene = preload("res://components/receipt/Receipt.tscn")

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
