extends CanvasLayer
## Skrypt, który w czasie gry wyświetla informacje na ekranie
##
## W czasie gry na ekranie wyświetlane są rózne informacje np. punkty

#region Stałe i zmienne
@onready var _score: Label = $PanelContainer/Score # Label do wyświetlania punktów
@onready var _level: Label = $PanelContainer/Level # Label do wyświetlania numeru układu

#endregion

## Metoda publiczna, która aktualizuje punkty wyświetlane na ekranie
func show_score(score : int) -> void:
	_score.text = "SCORE: " + str(score)

## Metoda publiczna, która wyświetla numer aktualnego układu	
func set_level(level : int) -> void:
	_level.text = "LEVEL: " + str(level)
