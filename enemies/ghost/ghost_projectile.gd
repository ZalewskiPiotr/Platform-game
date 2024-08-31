extends Node2D

@export var speed: int = 100

var direction

func start(pos, dir):
	position = pos
	direction = dir

func _physics_process(delta: float) -> void:
	position.x += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_kill_zone_body_entered(_body):
	queue_free()

func _on_kill_zone_area_entered(_area):
	queue_free()
