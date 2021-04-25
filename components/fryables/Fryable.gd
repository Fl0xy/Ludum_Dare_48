tool
extends RigidBody2D

export(Texture) var s0Texture: Texture
export(int) var s0Time: int
export(Texture) var s1Texture: Texture
export(int) var s1Time: int
export(Texture) var s2Texture: Texture
export(int) var s2Time: int
export(Texture) var s3Texture: Texture
export(int) var s3Time: int

enum {S0, S1, S2, S3, S4}
var state
var remainingTime: float = 0;
var inOil: bool = false
var held: bool = false
var offset: Vector2 = Vector2.ZERO

signal oil_entered
signal oil_exited

func _ready():
	$s0.texture = s0Texture
	$s1.texture = s1Texture
	$s2.texture = s2Texture
	$s3.texture = s3Texture
	
	$FryerIdentifier.connect("area_entered", self, "on_FryerIdentifer_Area_entered")
	$FryerIdentifier.connect("area_exited", self, "on_FryerIdentifer_Area_exited")
	
	state = S0
	remainingTime = s0Time
	$s1.visible = false
	$s2.visible = false
	$s3.visible = false
	
func _physics_process(delta):
	if inOil:
		remainingTime -= delta
		if remainingTime <= 0:
			match state:
				S0:
					$s0.visible = false
					$s1.visible = true
					state = S1
					remainingTime = s1Time
				S1:
					$s1.visible = false
					$s2.visible = true
					state = S2
					remainingTime = s2Time
				S2:
					$s2.visible = false
					$s3.visible = true
					state = S3
					remainingTime = s3Time
				S3:
					$s3.visible = false
					state = S4
					queue_free()
	
	if held:
		global_transform.origin = get_global_mouse_position() - offset
	
func _input_event(viewport, event, shape_idx):
	if !inOil:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				offset = event.position-global_position
				pickup()
			
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held && !event.pressed:
			drop()
			
func pickup():
	held = true

func drop():
	linear_velocity = Vector2(0,0)
	held = false
	
func on_FryerIdentifer_Area_entered(area):
	inOil = true
	drop()
	emit_signal("oil_entered")
	
func on_FryerIdentifer_Area_exited(area):
	inOil = false
	emit_signal("oil_exited")
