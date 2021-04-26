extends Node

enum EFryables {burger, fry, onion, tomato, special}

class OrderPoint:
	var fryable
	var degree: int
	var amount: int
	
class SpecialOrderPoint:
	var special_ref
	var degree: int

class Order:
	var order_points = []
	var special
	var receiptScene
	var customerScene
	var score: int
