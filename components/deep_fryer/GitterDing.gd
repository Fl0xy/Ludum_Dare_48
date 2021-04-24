extends StaticBody2D

const X_PLAY = 5
const Y_TOP = -52
const Y_BOT = -12
enum {BOT, HELD, FALLING, TOP}

onready var origin: Vector2 = position
var state = BOT
var offset: Vector2 = Vector2.ZERO

func _ready():
	$Area2D.connect("input_event", self, "_on_Area2D_input_event")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			offset = event.position - global_position
			state = HELD
	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if state == HELD && !event.pressed:
			state = FALLING
	
func _physics_process(delta):
	if state == HELD:
		var relative = position - (get_global_mouse_position() - offset)
		
		
		global_transform.origin = get_global_mouse_position() - offset
	
