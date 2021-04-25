tool
extends Node2D

enum numbers { one, two, three, four, five, six, seven, eight, nine, none, random }
enum fryables { burger, fry, onion, tomato, special, none, random }
enum frydegrees { one, two, three, death, none, random }

export(numbers) var amount_1 = numbers.random
export(fryables) var fryable_1 = fryables.random
export(frydegrees) var frydegree_1 = frydegrees.random

export(numbers) var amount_2 = numbers.none
export(fryables) var fryable_2 = fryables.none
export(frydegrees) var frydegree_2 = frydegrees.none

export(numbers) var amount_3 = numbers.none
export(fryables) var fryable_3 = fryables.none
export(frydegrees) var frydegree_3 = frydegrees.none

export(numbers) var amount_4 = numbers.none
export(fryables) var fryable_4 = fryables.none
export(frydegrees) var frydegree_4 = frydegrees.none

export(numbers) var amount_5 = numbers.none
export(fryables) var fryable_5 = fryables.none
export(frydegrees) var frydegree_5 = frydegrees.none

export(numbers) var amount_6 = numbers.none
export(fryables) var fryable_6 = fryables.none
export(frydegrees) var frydegree_6 = frydegrees.none


func set_order_paper(amount, fryable, frydegree, OrderPaperNode):
	# check if all options are set
	if (amount == numbers.none) or (fryable == fryables.none) or (frydegree == frydegrees.none):
		return
	
	# randomize if necessary
	if amount == numbers.random:
		amount = randi() % (numbers.size()-2)
	if fryable == fryables.random:
		fryable = randi() % (fryables.size()-2)
	if frydegree == frydegrees.random:
		frydegree = randi() % (frydegrees.size()-2)
	
	OrderPaperNode.amount = amount
	OrderPaperNode.fryable = fryable
	OrderPaperNode.fry_degree = frydegree
	
	OrderPaperNode.visible = true


func _enter_tree():
	randomize()
	
	$OrderPaper1.visible = false
	$OrderPaper2.visible = false
	$OrderPaper3.visible = false
	$OrderPaper4.visible = false
	$OrderPaper5.visible = false
	$OrderPaper6.visible = false

	set_order_paper(amount_1, fryable_1, frydegree_1, $OrderPaper1)
	set_order_paper(amount_2, fryable_2, frydegree_2, $OrderPaper2)
	set_order_paper(amount_3, fryable_3, frydegree_3, $OrderPaper3)
	set_order_paper(amount_4, fryable_4, frydegree_4, $OrderPaper4)
	set_order_paper(amount_5, fryable_5, frydegree_5, $OrderPaper5)
	set_order_paper(amount_6, fryable_6, frydegree_6, $OrderPaper6)

#	# check if all options are set
#	if (amount_1 == numbers.none) or (fryable_1 == fryables.none) or (frydegree_1 == frydegrees.none):
#		return
#	
#	# randomize if necessary
#	if amount_1 == numbers.random:
#		amount_1 = randi() % numbers.size()-2
#	if fryable_1 == fryables.random:
#		fryable_1 = randi() % fryables.size()-2
#	if frydegree_1 == frydegrees.random:
#		frydegree_1 = randi() % frydegrees.size()-2
#	
#	$OrderPaper1.amount = amount_1
#	$OrderPaper1.fryable = fryable_1
#	$OrderPaper1.fry_degree = frydegree_1
