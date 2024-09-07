extends CharacterBody2D
class_name Player
## Skrypt zarządzający postacią gracza
##
## Znajdują się tu funkcje, które zarządzają animacją, kierunkiem poruszania się, skakaniem.
## Obiekt 'Player' ma ustawioną wartość właściwości 'CanvasItem -> Ordering -> Z-index' na 10.
## Zrobione jest to w celu wyświetlania postaci gracza zawsze nawierzchu gry

#region Stałe i zmienne
enum States {OFF = 1, ON}
var state = States.OFF
var on_ladder := false
const SPEED = 200.0				# Szybkość gracza
const JUMP_VELOCITY = -300.0	# Wysokość skoku
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D	# Animacja postaci gracza
#endregion


#region Wbudowane funkcje silnika Godot
## Funkcja zarządza takimi aspektami gracza jak ruch, animacja, kolizje, itd
func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	match state:
		States.OFF:
			if should_climb_ladder():
				state = States.ON
			_jump(delta)
			_move(direction)
			_play_animation(direction)
		States.ON:
			if not on_ladder:
				state = States.OFF
			elif is_on_floor() and Input.is_action_pressed("move_down"):
				state = States.OFF
				Input.action_release("move_down")
				Input.action_release("move_up")
			elif Input.is_action_pressed("jump"):
				Input.action_release("move_down")
				Input.action_release("move_up")
				velocity.y = JUMP_VELOCITY
				state = States.OFF
			if Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
				_animated_sprite.play("climb")
			else:
				_animated_sprite.stop()
			_ladder_move()
#endregion


#region Ruch i animacja gracza
## Funkcja odpowiada za skok postaci gracza
## @param: delta - czas pomiędzy kolejnymi ramkami (frames)
func _jump(delta: float) -> void:
	# Dodanie grawitacji - jeżeli gracz jest w powietrzu
	if not self.is_on_floor():
		velocity += self.get_gravity() * delta

	# Przechwycenie komendy skoku - jeżeli gracz jest na podłodze
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		AudioSfx.player_jump()


## Funkcja odpowiada za poruszanie postacią gracza w lewo i prawo
## @param: direction - kierunek w jakim porusza się postać gracza: 1-prawo;0-stoi w miejscu;-1-lewo
func _move(direction : float) -> void:
	# Ruch lewo-prawo
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _ladder_move() -> void:
	if Input.is_action_pressed("move_up"):
		velocity.y = -SPEED/2
	elif Input.is_action_pressed("move_down"):
		velocity.y = SPEED/2
	else:
		velocity.y = lerp(velocity.y,0.0,0.3)
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED/6
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED/6
	else:
		velocity.x = lerp(velocity.x,0.0,0.3)
	
	move_and_slide()

## Funkcja zarządza wyświetlaniem animacji gracza
## @param: direction - kierunek w jakim porusza się postać gracza: 1-prawo;0-stoi w miejscu;-1-lewo
func _play_animation(direction : float):
	if self.is_on_floor(): # Tylko jak postać jest na podłodze
		if direction > 0: # Postać idzie w prawo
			_animated_sprite.flip_h = false
			_animated_sprite.play("run")
		elif direction < 0: # Postać idzie w lewo 
			_animated_sprite.flip_h = true
			_animated_sprite.play("run")
		else: # Postać stoi w miejscu
			_animated_sprite.play("idle")
	else:
		_animated_sprite.play("jump")
		if direction > 0:
			_animated_sprite.flip_h = false
		elif direction < 0:
			_animated_sprite.flip_h = true
#endregion

func should_climb_ladder() -> bool:
	if on_ladder and (Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down")):
		return true
	else:
		return false

func _on_ladder_checker_body_entered(_body):
	on_ladder = true


func _on_ladder_checker_body_exited(_body):
	on_ladder = false
