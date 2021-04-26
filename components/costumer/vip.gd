extends Node2D

signal orderDone

export(PackedScene) var special: PackedScene
export(int) var degree = 4

func _ready():
	if !Engine.is_editor_hint():
		var timer: SceneTreeTimer = get_tree().create_timer(3.0)
		timer.connect("timeout", self, "makeOrder")
	
func makeOrder():
	var order: Dtos.Order = OrderSystem.addOrder(self, special.instance(), degree)
	var timer: SceneTreeTimer = get_tree().create_timer(5)
	timer.connect("timeout", self, "orderDoneHelper")
	
func orderDoneHelper():
	emit_signal("orderDone")
	
func getHead():
	return $head
func getFrontHair():
	return null
func getBackHair():
	return null
