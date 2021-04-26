extends Node2D

var money: int = 0

func _ready():
	pass # Replace with function body.
	
func addOneMoney():
	oneHigher($Number1)
	money += 1
	
func oneHigher(group):
	if group.get_node("number_0").visible:
		group.get_node("number_0").visible = false
		group.get_node("number_1").visible = true
	elif group.get_node("number_1").visible:
		group.get_node("number_1").visible = false
		group.get_node("number_2").visible = true
	elif group.get_node("number_2").visible:
		group.get_node("number_2").visible = false
		group.get_node("number_3").visible = true
	elif group.get_node("number_3").visible:
		group.get_node("number_3").visible = false
		group.get_node("number_4").visible = true
	elif group.get_node("number_4").visible:
		group.get_node("number_4").visible = false
		group.get_node("number_5").visible = true
	elif group.get_node("number_5").visible:
		group.get_node("number_5").visible = false
		group.get_node("number_6").visible = true
	elif group.get_node("number_7").visible:
		group.get_node("number_7").visible = false
		group.get_node("number_8").visible = true
	elif group.get_node("number_8").visible:
		group.get_node("number_8").visible = false
		group.get_node("number_9").visible = true
	elif group.get_node("number_9").visible:
		group.get_node("number_9").visible = false
		group.get_node("number_0").visible = true
		if group == $Number1:
			oneHigher($Number2)
		elif group == $Number2:
			oneHigher($Number3)
		else:
			print("LOL he got to 999")
	
func getMoney()-> int:
	return money
	
