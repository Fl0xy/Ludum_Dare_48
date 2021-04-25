tool
extends Node2D

enum numbers { one, two, three, four, five, six, seven, eight, nine }
export(numbers) var amount

enum fryables { burger, fry, onion, tomato, special }
export(fryables) var fryable

enum frydegrees { one, two, three, death }
export(frydegrees) var fry_degree

func _enter_tree():
	# because the tool is always doing stuff hide every sub grafic
	for c in $Number.get_children(): c.visible = false
	for c in $Fryables.get_children(): c.visible = false
	for c in $FryDegree.get_children(): c.visible = false
	for c in $SpecialFryDegree.get_children(): c.visible = false
	$recipe_x.visible = false
	
	# make visible what was set to be so
	if fryable == fryables.special:
		$Fryables/Special.visible = true
		
		match fry_degree:
			frydegrees.one:
				$SpecialFryDegree/One.visible = true
			frydegrees.two:
				$SpecialFryDegree/Two.visible = true
			frydegrees.three:
				$SpecialFryDegree/Three.visible = true
			frydegrees.death:
				$SpecialFryDegree/Death.visible = true
	else:
		$recipe_x.visible = true
		
		match fryable:
			fryables.burger:
				$Fryables/Burger.visible = true
			fryables.fry:
				$Fryables/Fry.visible = true
			fryables.onion:
				$Fryables/Onion.visible = true
			fryables.tomato:
				$Fryables/Tomato.visible = true
		
		match fry_degree:
			frydegrees.one:
				$FryDegree/One.visible = true
			frydegrees.two:
				$FryDegree/Two.visible = true
			frydegrees.three:
				$FryDegree/Three.visible = true
		
		match amount:
			numbers.one:
				$Number/recipe_number_1.visible = true
			numbers.two:
				$Number/recipe_number_2.visible = true
			numbers.three:
				$Number/recipe_number_3.visible = true
			numbers.four:
				$Number/recipe_number_4.visible = true
			numbers.five:
				$Number/recipe_number_5.visible = true
			numbers.six:
				$Number/recipe_number_6.visible = true
			numbers.seven:
				$Number/recipe_number_7.visible = true
			numbers.eight:
				$Number/recipe_number_8.visible = true
			numbers.nine:
				$Number/recipe_number_9.visible = true
