extends StaticBody2D

const X_PLAY = 3
const Y_TOP = -52
const Y_BOT = -12
const THRESHOLD = 5
const FALL_VEC = Vector2(0,0.5)
enum {BOT, HELDTHRESHOLD, HELD, FALLING, TOP}

onready var origin: Vector2 = position
var state = BOT
var mouseClickedPos: Vector2 = Vector2.ZERO

func _ready():
	$Area2D.connect("input_event", self, "_on_Area2D_input_event")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			mouseClickedPos = event.position
			state = HELDTHRESHOLD
	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if !event.is_pressed():
			if state == HELD:
				state = FALLING
			if state == HELDTHRESHOLD:
				if Y_TOP - position.y < Y_BOT - position.y:
					state = TOP
				else:
					state = BOT
				
	
func _physics_process(delta):
	if state == HELDTHRESHOLD:
		var offset: Vector2 = get_global_mouse_position() - mouseClickedPos
		var tmpPos: Vector2 = offset + origin
		
		# X axis Play
		if tmpPos.x < origin.x - X_PLAY:
			tmpPos.x = origin.x - X_PLAY
		elif tmpPos.x > origin.x + X_PLAY:
			tmpPos.x = origin.x + X_PLAY
		
		if tmpPos.y <= Y_TOP:
			tmpPos.y = Y_TOP
			offset.y = -THRESHOLD
		elif tmpPos.y >= Y_BOT:
			tmpPos.y = Y_BOT
			offset.y = THRESHOLD
			
		if abs(offset.y) > THRESHOLD:
			state = HELD
			if tmpPos.y < -35:
				$AudioUnclick.play()
			
		position = tmpPos
		
	if state == HELD:
		var offset: Vector2 = get_global_mouse_position() - mouseClickedPos
		var tmpPos: Vector2 = offset + origin
		
		# X axis Play
		if tmpPos.x < origin.x - X_PLAY:
			tmpPos.x = origin.x - X_PLAY
		elif tmpPos.x > origin.x + X_PLAY:
			tmpPos.x = origin.x +X_PLAY
		
		if tmpPos.y <= Y_TOP:
			tmpPos.y = Y_TOP
			state = HELDTHRESHOLD
			mouseClickedPos = get_global_mouse_position()
			origin.y = Y_TOP
			$AudioClick.play()
		elif tmpPos.y >= Y_BOT:
			tmpPos.y = Y_BOT
			state = HELDTHRESHOLD
			mouseClickedPos = get_global_mouse_position()
			origin.y = Y_BOT
			#$AudioClick.play()
		position = tmpPos
	
	if state == FALLING:
		var tmpPos = position + FALL_VEC
		if tmpPos.y >= Y_BOT:
			tmpPos.y = Y_BOT
			state = BOT
			origin.y = Y_BOT
			#$AudioClick.play()
		position = tmpPos
	
