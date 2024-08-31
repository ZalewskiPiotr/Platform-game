extends Node2D

@export var speed = 60

var direction = -1

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_left_ground = $RayCastLeftGround
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_right_ground = $RayCastRightGround
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
	if not ray_cast_right_ground.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = true
	if not ray_cast_left_ground.is_colliding():
		direction = 1
		animated_sprite.flip_h = true
	
	position.x += direction * speed * delta
