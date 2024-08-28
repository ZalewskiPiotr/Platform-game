extends Area2D
class_name Door


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.goto_scene(GameManager.EnumScenes.TEST_LEVEL)
