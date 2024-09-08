extends AnimatableBody2D

@export var offset = Vector2(200, 0)
@export var duration = 5.0

func _ready():
	start_tween()

func start_tween():
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(self, "position", self.position + offset, duration / 2)
	tween.tween_property(self, "position", self.position, duration / 2)
