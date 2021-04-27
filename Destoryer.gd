extends Area2D


func _ready():
	pass # Replace with function body.


func _on_Destoryer_body_entered(body):
	body.queue_free()
