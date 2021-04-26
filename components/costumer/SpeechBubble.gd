extends Node2D

var currentReciept
var stopAudio: bool = false

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
	var pitch = 1 - ((randf() - 0.5)  / 2)
	print(pitch)
	$AudioStreamPlayer2D.pitch_scale = pitch
	$AudioStreamPlayer2D.play()
	stopAudio = false
	var timer: SceneTreeTimer = get_tree().create_timer(2)
	timer.connect("timeout", self, "on_timer_timeout")

func on_timer_timeout():
	$AnimatedDeploy.visible = false
	$AnimatedDestory.visible = true
	$AnimatedDestory.frame = 0
	$AnimatedDestory.play()
	stopAudio = true
	get_node("/root/Main/RecipeHolder").addReciept(currentReciept)
	
func _on_AnimatedDestory_animation_finished():
	$AnimatedDestory.visible = false


func audio_loop():
	if !stopAudio:
		$AudioStreamPlayer2D.play()
