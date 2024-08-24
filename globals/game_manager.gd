extends Node


var _score : int = 0

func _ready() -> void:
	GlobalEvents.coin_collected.connect(add_point)

func add_point() -> void:
	print("point for coin added. Total point: ", str(_score))
	_score += 1
