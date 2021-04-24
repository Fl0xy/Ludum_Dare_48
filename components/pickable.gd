extends RigidBody2D

var held: bool = false
var offset: Vector2 = Vector2.ZERO

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			offset = event.position-global_position
			pickup()
			
func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position() - offset
		
func pickup():
	#mode = RigidBody2D.MODE_STATIC
	held = true


func drop(impulse=Vector2.ZERO):
	print(impulse)
	linear_velocity = Vector2(0,9)
	held = false


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held && !event.pressed:
			drop()



