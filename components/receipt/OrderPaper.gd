tool
extends Node2D

export(int) var amount

enum fryables { burger, fry, onion, tomato, special }
export(fryables) var fryable

export(int) var fry_degree

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
			1:
				$SpecialFryDegree/One.visible = true
			2:
				$SpecialFryDegree/Two.visible = true
			3:
				$SpecialFryDegree/Three.visible = true
			4:
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
			1:
				$FryDegree/One.visible = true
			2:
				$FryDegree/Two.visible = true
			3:
				$FryDegree/Three.visible = true
		
		match amount:
			1:
				$Number/recipe_number_1.visible = true
			2:
				$Number/recipe_number_2.visible = true
			3:
				$Number/recipe_number_3.visible = true
			4:
				$Number/recipe_number_4.visible = true
			5:
				$Number/recipe_number_5.visible = true
			6:
				$Number/recipe_number_6.visible = true
			7:
				$Number/recipe_number_7.visible = true
			8:
				$Number/recipe_number_8.visible = true
			9:
				$Number/recipe_number_9.visible = true
