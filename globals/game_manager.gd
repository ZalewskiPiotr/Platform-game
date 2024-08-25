extends Node
## Skrypt przechowuje globalne zmienne i funkcje do wykorzystania w całej grze
##
## Region 'Zarządzanie punktami' - 


#region Zmienne i stałe
var _score : int = 0	# Punkty gracza zdobywane w grze
#endregion


#region Inicjalizacja skryptu
## Załadowanie globalnych sygnałów
func _ready() -> void:
	GlobalEvents.coin_collected.connect(_add_point)
	GlobalEvents.player_hit.connect(_on_player_hit)
#endregion


#region Zarządzanie punktami
## Metoda publiczna. Podaje liczbę aktualnych punktów
func get_score() -> int:
	return _score

## Metoda publiczna. Resetuje punkty gracza.
func reset_score() -> void:
	_score = 0
	print("Punkty wyzerowane. Aktualne punkty: ", str(_score))

## Dodanie punktu
func _add_point() -> void:
	_score += 1
	print("Punkt dodany. Aktualne punkty: ", str(_score))
	

#endregion

## Co się dzieje w momencie gdy gracz zostaje trafiony. Obecnie resetowane są punkty. Docelowo
## powinno nastąpić wyjście do menu głównego gry
func _on_player_hit() -> void:
	print("Gracz został trafiony")
	self.reset_score()
