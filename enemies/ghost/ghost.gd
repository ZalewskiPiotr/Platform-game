extends Node2D

@export var cooldown = 2.0

var bullet_scene = preload("res://enemies/ghost/ghost_projectile.tscn")
var dir = 0
var pos = Vector2(0, 0)

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	$ShootTimer.wait_time = cooldown
	if animated_sprite.flip_h == false:
		dir = -1
	else:
		dir = 1

func _on_shoot_timer_timeout():
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	pos = Vector2(position.x, position.y - 15)
	b.start(pos, dir)
	$ShootTimer.start()
