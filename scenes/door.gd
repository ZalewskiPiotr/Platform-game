extends Area2D
class_name Door
## Skrypt obsługujący drzwi


## Jeżeli gracz wjedzie w drzwi to zostanie przeniesiony do następnego układu
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.goto_scene(GameManager.EnumScenes.TEST_LEVEL)
