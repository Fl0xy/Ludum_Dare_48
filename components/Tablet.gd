extends Node2D

var fryables = []

func _ready():
	pass # Replace with function body.



func _on_Area2D_area_entered(area: Area2D):
	fryables.append(area.get_parent())
	
	if fryables.size() == 5:
		for fryable in fryables:
			if fryable.state != fryable.S1:
				return
				
		for fryable in fryables:
			fryable.queue_free()
		fryables.clear()


func _on_Area2D_area_exited(area: Area2D):
	fryables.erase(area.get_parent())
		
