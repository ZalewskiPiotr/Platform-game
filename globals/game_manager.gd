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
#endregion


#region Zarządzanie punktami
## Metoda publiczna. Podaje liczbę aktualnych punktów
func get_score() -> int:
	return _score

## Dodanie punktu
func _add_point() -> void:
	_score += 1
	print("point added. Total point: ", str(_score))
#endregion
