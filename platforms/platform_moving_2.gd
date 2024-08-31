extends AnimatableBody2D

# To działa na takie jzasadzie, że jest globalna grupa 'Ground' do któależy TileMapLayer 'Floor'
# Jak platforma napotka obiekty tej warsty to się odbija w drugim kierunku

@export var _move_speed = 0.5
var _move_direction = Vector2.LEFT

func _physics_process(_delta: float) -> void:
	move_and_collide(_move_direction * _move_speed)


func _on_left_sensor_body_entered(body: Node2D) -> void:
	if body.is_in_group("GroupGround"):
		_move_direction = Vector2.RIGHT


func _on_right_sensor_body_entered(body: Node2D) -> void:
	if body.is_in_group("GroupGround"):
		_move_direction = Vector2.LEFT
