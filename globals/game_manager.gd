extends Node
## Skrypt przechowuje globalne zmienne i funkcje do wykorzystania w całej grze
##
## Region 'Inicjalizacja skryptu' - metody 'init' oraz 'ready'
## Region 'Zarządzanie punktami gracza' - Wszystko co się dzieje z punktacją gry
## Region 'Zarządzanie scenami' - Funkcje do zmiany scen


#region Enumeratory
enum EnumScenes {
	START_PAGE, 
	LEVEL_1,
	LEVEL_2,
	TEST_LEVEL
}
#endregion


#region Zmienne i stałe
var _score : int = 0	# Punkty gracza zdobywane w grze
var _current_scene : Node = null	# Aktualna scena
#endregion


#region Inicjalizacja skryptu
## Załadowanie globalnych sygnałów i ustawienie globalnych zmiennych
func _ready() -> void:
	# Ładowanie sygnałów
	GlobalEvents.coin_collected.connect(_add_point)
	GlobalEvents.player_hit.connect(_on_player_hit)
	
	# Ładowanie aktywnej sceny
	_current_scene = _get_current_scene()
	print(_current_scene)
#endregion


#region Zarządzanie punktami gracza
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


#region Zarządzanie scenami
## Funkcja zmienia aktualną scenę na podaną 
## @param: path - ścieżka do sceny, która ma być załadowana
func goto_scene(new_scene : EnumScenes) -> void:
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	var path : String = _get_path_to_scene(new_scene)
	call_deferred("_deferred_goto_scene", path)


## Funkcja na podstawie podanej wartości enumeratora zwraca ścieżkę do sceny
## @param: scene - wartośc enumeratora dla ścieżki, która ma zostać zwrócona
func _get_path_to_scene(scene : EnumScenes) -> String:
	var path : String
	if scene == EnumScenes.START_PAGE:
		path = "res://scenes/start_page.tscn"
	elif scene == EnumScenes.LEVEL_1:
		path = "res://levels/level_1.tscn"
	elif scene == EnumScenes.LEVEL_2:
		path = "res://levels/level_2.tscn"
	elif scene == EnumScenes.TEST_LEVEL:
		path = "res://levels/level_test_1.tscn"
	else:
		path = ""
	return path
	
	
## Zmiana sceny. Uusnięcie aktualnej sceny i załadowanie nowej.
## Z uwagi na to, że w tej funkcji jest wołana metoda '.free()', nie można bezpośrednio wywoływać
## tej funkcji. Zawsze musi to być wywołanie: call_deferred("_deferred_goto_scene", path)
func _deferred_goto_scene(path : String) -> void:
	# It is now safe to remove the current scene.
	# Czasem obiekt _current_scene jest null. Spowodowane jest to użyciem metody
	# 'reload_current_scene' np. w momencie śmierci gracza. W takim wypadku aktualna scena jest
	# ładowana na nowo i tracona jest referencja do poprzedniej instancji sceny. Stąd sprawdzenie
	# czy aktualna scena jest null. Jeżeli tak to należy pobrać ją na nowo. W miejscu jeszcze
	# istnieje ona w drzewie na ostatniej pozycji.
	if _current_scene == null:
		_current_scene = _get_current_scene()
	_current_scene.free()
	# Load the new scene.
	var res : Resource = ResourceLoader.load(path)
	# Instance the new scene.
	_current_scene = res.instantiate()
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(_current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = _current_scene


## Pobranie aktualnej sceny
## The current scene and global scripts are children of root, but autoloaded nodes (global scripts)
## are always first. This means that the last child of root is always the loaded/current scene.
func _get_current_scene() -> Node:
	var root : Window = get_tree().root
	var node = root.get_child(root.get_child_count() - 1)
	return node


## Przeładowanie aktualnej sceny	
func _reload_current_scene() -> void:
	var scene : Node = get_tree().current_scene
	var path_to_scene : String = scene.scene_file_path
	call_deferred("_deferred_goto_scene", path_to_scene)
#endregion


## Co się dzieje w momencie gdy gracz zostaje trafiony. Obecnie resetowane są punkty. Docelowo
## powinno nastąpić wyjście do menu głównego gry
func _on_player_hit() -> void:
	print("Gracz został trafiony")
	self.reset_score()
	_reload_current_scene() # Gracz ma jedno życie. Po śmierci gracza ładujemy układ na nowo.
