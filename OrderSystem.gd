extends Node

enum fryables { burger, fry, onion, tomato, special }
export(fryables) var fryable

enum frydegrees { one, two, three, death }
export(frydegrees) var fry_degree

class OrderPoint:
	var fryable
	var frydegree
	var amount
	var special_ref = null

class Order:
	var order_points = []

#class Order:
#	var fry = [0,0,0] # amount_degree_1, amount_degree2, ...
#	var onion = [0,0,0]
#	var tomato = [0,0,0]
#	var burger = [0,0,0]
#	var special = [[0,null]] # [degree,node_ref]

var waiting_orders = []
var recipe_holder # reference is set from the RecipHolder itself

func order_smth(order : Order):
	waiting_orders += [order]
	recipe_holder.place_recip(order)




func get_order_from_recipe(recipe):
	# TODO
	pass


# NOTE: THIS ONLY WORKS IF THERE ARE NO POINTS WITH EQUAL FRY ABLE DEGREE
func is_recipe_matching_order(recipe, order) -> bool:
	var recipe_order = get_order_from_recipe(recipe)
	for point1 in order.order_points:
		var found_equal_point = false
		for point2 in recipe_order.order_points:
			if point1.fryable != point2.fryable: continue
			if point1.frydegree != point2.frydegree: continue
			if point1.amount != point2.amount: continue
			if point1.special_ref != point2.special_ref: continue
			found_equal_point = true
			break
		if not found_equal_point: return false
	return true
	

func is_recipe_matching_a_waiting_order(recipe):
	for order in waiting_orders:
		if is_recipe_matching_order(recipe, order):
			return true;
	return false
