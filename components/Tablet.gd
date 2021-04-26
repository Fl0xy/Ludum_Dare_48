extends Node2D

var fryables = []

func _ready():
	pass # Replace with function body.



func _on_Area2D_area_entered(area: Area2D):
	fryables.append(area.get_parent())


func _on_Area2D_area_exited(area: Area2D):
	fryables.erase(area.get_parent())
		

func _on_Area2D2_body_entered(body):
	OrderSystem.fulfillOrder(body, fryables)
	fryables.clear()


