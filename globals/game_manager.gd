extends Node


var _score : int = 0

func _ready() -> void:
	GlobalEvents.coin_collected.connect(_add_point)

func _add_point() -> void:
	_score += 1
	print("point added. Total point: ", str(_score))
