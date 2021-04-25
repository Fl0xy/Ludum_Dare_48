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
	var is_special_destroyed = false

class Order:
	var order_points = []

var recipe_holder # reference is set from the RecipHolder itself

var waiting_orders = []

func order_smth(order : Order):
	recipe_holder.place_recip(order)
	waiting_orders += [order]


func get_order_from_delivery(delivery):
	# TODO
	pass

func is_equal_order(order1, order2) -> bool:
	for point1 in order1.order_points:
		var found_equal_point = false
		for point2 in order2.order_points:
			if point1.fryable != point2.fryable: continue
			if point1.frydegree != point2.frydegree: continue
			if point1.amount != point2.amount: continue
			if point1.special_ref != point2.special_ref: continue
			
			
			
	return false

func is_delivery_matching_order(delivery):
	for o in waiting_orders:
		var del_order = get_order_from_delivery(delivery)
		if is_equal_order(o, del_order):
			return true;
	return false
