tool
extends RigidBody2D

enum fryables { burger, fry, onion, tomato, special }
export(fryables) var type = fryables.special
export(Texture) var s0Texture: Texture
export(int) var s0Time: int
export(Texture) var s1Texture: Texture
export(int) var s1Time: int
export(Texture) var s2Texture: Texture
export(int) var s2Time: int
export(Texture) var s3Texture: Texture
export(int) var s3Time: int

enum {S0, S1, S2, S3, S4}
var degree
var remainingTime: float = 0;
var inOil: bool = false
var held: bool = false
var offset: Vector2 = Vector2.ZERO

onready var orgCollision = collision_layer
onready var orgMask = collision_mask
const areaModeCollision = pow(2,19)
const areaModeMask = pow(2,9)

signal oil_entered
signal oil_exited

func _ready():
	$s0.texture = s0Texture
	$s1.texture = s1Texture
	$s2.texture = s2Texture
	$s3.texture = s3Texture
	
	$FryerIdentifier.connect("area_entered", self, "on_FryerIdentifer_Area_entered")
	$FryerIdentifier.connect("area_exited", self, "on_FryerIdentifer_Area_exited")
	$TabletIdentifier.connect("area_entered", self, "on_TabletIdentifier_Area_entered")
	$TabletIdentifier.connect("area_exited", self, "on_TabletIdentifer_Area_exited")
	$Audio.connect("finished", self, "on_Audio_finished")
	
	degree = S0
	remainingTime = s0Time
	$s1.visible = false
	$s2.visible = false
	$s3.visible = false
	
func _physics_process(delta):
	if inOil:
		remainingTime -= delta
		if remainingTime <= 0:
			match degree:
				S0:
					$s0.visible = false
					$s1.visible = true
					degree = S1
					remainingTime = s1Time
				S1:
					$s1.visible = false
					$s2.visible = true
					degree = S2
					remainingTime = s2Time
				S2:
					$s2.visible = false
					$s3.visible = true
					degree = S3
					remainingTime = s3Time
				S3:
					$s3.visible = false
					degree = S4
					mode = RigidBody2D.MODE_STATIC
					collision_layer = 0
					collision_mask = 0
					input_pickable = false
					$Audio.destory()
	
	if held:
		global_transform.origin = get_global_mouse_position() - offset
	
func _input_event(viewport, event, shape_idx):
	if !inOil:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				offset = event.position-global_position
				pickup()
			if event.button_index == BUTTON_WHEEL_UP:
				global_rotation_degrees += 5
			if event.button_index == BUTTON_WHEEL_DOWN:
				global_rotation_degrees -= 5
			
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
	
func on_TabletIdentifier_Area_entered(area):
	collision_layer = areaModeCollision
	collision_mask = areaModeMask
	
func on_TabletIdentifer_Area_exited(area):
	collision_layer = orgCollision
	collision_mask = orgMask
	
func on_Audio_finished():
	queue_free()
