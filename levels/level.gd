extends Node
class_name Level
## Skrypt, który zarządza tym co się dzieje w scenie levelu
##
## Jest to główna klasa 'Level'. Wszystkie inne układy dziedziczą po tej klasie. Aby utworzyć
## dziedziczoną scenę 'Level_x' należy kliknąć PPM na scenie 'Level' i wybrać opcję 'New Inherited
## scene'. Utworzy się wówczas nowa scena z oznaczonymi na żółto podobiektami. Do takiej sceny 
## będzie podłączony skrypt sceny głównej.
## Jeżeli potrzebujemy przeciążyć metody klasy dziedziczonej lub dodać nowe to należy utworzyć nową 
## klasę dziedziczoną jak powyżej. Następnie należy odłączyć skrypt i dodać nowy. W skrypcie należy 
## dodać następujące linie:
## extends Level
## class_name LevelTest2
## i napisać przeciążone lub nowe metody

#region Stałe i zmienne
@onready var _hud: CanvasLayer = $HUD	# Dostęp do HUD
#endregion


## Podłączenie sygnałów i początkowe ustawienie informacji na HUD
func _ready() -> void:
	GlobalEvents.coin_collected.connect(_on_coin_collected)
	_hud.show_score(GameManager.get_score())

## Aktualizacja HUD w momencie zebrania coina
func _on_coin_collected() -> void:
	_hud.show_score(GameManager.get_score())
