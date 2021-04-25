extends Area2D

export(PackedScene) var FryableScene: PackedScene

func _ready():
	pass # Replace with function body.

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var fryable = FryableScene.instance()
			get_tree().get_root().get_child(0).add_child(fryable)
			fryable.global_transform.origin = get_global_mouse_position()
			fryable.pickup()
			
