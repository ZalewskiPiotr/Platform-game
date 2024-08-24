extends Area2D
class_name Coin

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	print("coin collected")
	GlobalEvents.coin_collected.emit()
	self.queue_free()
