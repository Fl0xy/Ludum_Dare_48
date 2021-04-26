extends Node2D

var playerQueue = []
var playing: Dtos.Order

func _enter_tree():
	OrderSystem.emote = self

func _ready():
	$Angry.visible = false
	$Happy.visible = false
	$Money.visible = false
	$AnimationPlayer.connect("animation_finished", self, "on_animation_finished")
	
	#if Engine.is_editor_hint():
	#	add_child(preload("res://components/costumer/heads/Head_1.tscn").instance())
	#	$Angry.visible = true

func playEmote(order: Dtos.Order):
	playerQueue.append(order)
	
func _physics_process(delta):
	if playerQueue.size() > 0 and !$AnimationPlayer.is_playing():
		var order: Dtos.Order = playerQueue.pop_front()
		var customerScene = order.customerScene	
		
		var frontHair: Node2D = customerScene.getFrontHair()
		var head: Node2D = customerScene.getHead()
		var backHair: Node2D = customerScene.getBackHair()
		
		head.get_parent().remove_child(head)
		backHair.get_parent().remove_child(backHair)
		frontHair.get_parent().remove_child(frontHair)
		
		
		$HeadContainer.add_child(backHair)
		$HeadContainer.add_child(head)
		$HeadContainer.add_child(frontHair)
		backHair.position = head.get_node("Hair").position
		backHair.visible = true
		head.position = Vector2.ZERO
		head.visible = true
		frontHair.position = head.get_node("Hair").position
		frontHair.visible = true
		
		
		if order.score > 0:
			$Happy.visible = true
			$Money.visible = true
			$AnimationPlayer.play("money")
			get_node("/root/Main/CashRegister").addOneMoney()
			$coin.play()
		else:
			$Angry.visible = true
			$no.play()
			var timer: SceneTreeTimer = get_tree().create_timer(1)
			timer.connect("timeout", self, "on_animation_finished", [""])
		playing = order

func on_animation_finished(name):
	$Angry.visible = false
	$Happy.visible = false
	$Money.visible = false
	for child in $HeadContainer.get_children():
		child.queue_free()
	playing.customerScene.queue_free()
