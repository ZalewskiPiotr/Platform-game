extends Area2D
class_name Door
## Skrypt obsługujący drzwi
##
## Skrypt posiada zmienną @export o nazwie 'Door to level'. W każdej instancji drzwi należy ustawić
## układ, do którego rpowadzą drzwi

#region Stałe i zmienne
@export var _door_to_level : GameManager.EnumScenes	# Do którego układu prowadzą drzwi
#endregion

## Jeżeli gracz wejdzie w drzwi to zostanie przeniesiony do następnego układu
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.goto_scene(_door_to_level)
