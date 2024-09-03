extends CharacterBody2D
class_name Player
## Skrypt zarządzający postacią gracza
##
## Znajdują się tu funkcje, które zarządzają animacją, kierunkiem poruszania się, skakaniem.
## Obiekt 'Player' ma ustawioną wartość właściwości 'CanvasItem -> Ordering -> Z-index' na 10.
## Zrobione jest to w celu wyświetlania postaci gracza zawsze nawierzchu gry

#region Stałe i zmienne
const SPEED = 200.0				# Szybkość gracza
const JUMP_VELOCITY = -300.0	# Wysokość skoku
@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D	# Animacja postaci gracza
#endregion


#region Wbudowane funkcje silnika Godot
## Funkcja zarządza takimi aspektami gracza jak ruch, animacja, kolizje, itd
func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	_jump(delta)
	_move(direction)
	_play_animation(direction)
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
