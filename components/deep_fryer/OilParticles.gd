extends Node2D

var col_old: bool = false


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var col = $RayCast2D.is_colliding();
	if col_old == col:
		return
	if col:
		$ParticlesIdle.emitting = false
		$ParticlesWork.emitting = true
		print("party")
		col_old = true
	else:
		$ParticlesWork.emitting = false
		$ParticlesIdle.emitting = true
		print("no party")
		col_old = false
