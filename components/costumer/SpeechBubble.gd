extends Node2D

var currentReciept

func _ready():
	$AnimatedDeploy.visible = false
	$AnimatedDestory.visible = false

func showReciept(reciept: Recipe):
	currentReciept = reciept
	$AnimatedDeploy.visible = true
	$AnimatedDeploy.frame = 0
	$AnimatedDeploy.play()
		

func _on_AnimatedDeploy_animation_finished():
	currentReciept.global_position = $RecieptPos.global_position
	currentReciept.visible = true
	var timer: SceneTreeTimer = get_tree().create_timer(2)
	timer.connect("timeout", self, "on_timer_timeout")

func on_timer_timeout():
	$AnimatedDeploy.visible = false
	$AnimatedDestory.visible = true
	$AnimatedDestory.frame = 0
	$AnimatedDestory.play()
	get_node("/root/Main/RecipeHolder").addReciept(currentReciept)
	
func _on_AnimatedDestory_animation_finished():
	$AnimatedDestory.visible = false