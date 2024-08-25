extends CanvasLayer
## Skrypt, który w czasie gry wyświetla informacje na ekranie
##
## W czasie gry na ekranie wyświetlane są rózne informacje np. punkty

#region Stałe i zmienne
@onready var _score: Label = $Score	# Label do wyświetlania punktów
#endregion

## Metoda publiczna, która aktualizuje punkty wyświetlane na ekranie
func show_score(score : int):
	_score.text = "SCORE: " + str(score)
