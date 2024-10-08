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
@onready var _hud : CanvasLayer = $HUD	# Dostęp do HUD
@export var _level_number : int # Numer układu. Musi być ustawiony ręcznie przez programistę
#endregion

func _input(event: InputEvent) -> void:
	# Wyjście do menu głównego
	if event.is_action_pressed("ESC"):
		GameManager.reset_score()	# Trzeba wyzerować punkty
		GameManager.goto_scene(GameManager.EnumScenes.START_PAGE)
	if event.is_action_pressed("HiddenPassage"):
		match _level_number:
			1:
				GameManager.goto_scene(GameManager.EnumScenes.LEVEL_2)
			2:
				GameManager.goto_scene(GameManager.EnumScenes.LEVEL_3)
			3:
				GameManager.goto_scene(GameManager.EnumScenes.LEVEL_4)
			4:
				GameManager.goto_scene(GameManager.EnumScenes.LEVEL_5)
			5:
				GameManager.goto_scene(GameManager.EnumScenes.LEVEL_1)

## Podłączenie sygnałów i początkowe ustawienie informacji na HUD
func _ready() -> void:
	GlobalEvents.coin_collected.connect(_on_coin_collected)
	_hud.show_score(GameManager.get_score())
	_hud.set_level(_level_number)

## Aktualizacja HUD w momencie zebrania coina
func _on_coin_collected() -> void:
	_hud.show_score(GameManager.get_score())
