extends Node
## Skrypt przechowuje globalne zmienne i funkcje do wykorzystania w całej grze
##
## Region 'Zarządzanie punktami' - 


#region Zmienne i stałe
var _score : int = 0	# Punkty gracza zdobywane w grze
var _current_scene : Node = null	# Aktualna scena
#endregion


#region Inicjalizacja skryptu
## Załadowanie globalnych sygnałów
func _ready() -> void:
	GlobalEvents.coin_collected.connect(_add_point)
	GlobalEvents.player_hit.connect(_on_player_hit)
	_current_scene = _get_current_scene()
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

#region Zarządzanie scenami
func goto_scene(path : String) -> void:
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path : String) -> void:
	_current_scene.free()
	var res : Resource = ResourceLoader.load(path)
	_current_scene = res.instantiate()
	get_tree().root.add_child(_current_scene)
	get_tree().current_scene = _current_scene

## Pobranie aktualnej sceny
## The current scene and global scripts are children of root, but autoloaded nodes (global scripts)
## are always first. This means that the last child of root is always the loaded/current scene.
func _get_current_scene() -> Node:
	var root : Window = get_tree().root
	var node = root.get_child(root.get_child_count() - 1)
	return node
#endregion

## Co się dzieje w momencie gdy gracz zostaje trafiony. Obecnie resetowane są punkty. Docelowo
## powinno nastąpić wyjście do menu głównego gry
func _on_player_hit() -> void:
	print("Gracz został trafiony")
	self.reset_score()
