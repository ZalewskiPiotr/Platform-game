extends Node2D

@export var flight_height = Vector2(0, -100)
@export var flight_time = 5.0

func _ready():
	start_tween()

func start_tween():
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(self, "position", self.position + flight_height, flight_time / 2)
	tween.tween_property(self, "position", self.position, flight_time / 2)
