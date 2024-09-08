extends Control
## Menu główne gry
##
## Jest to strona startowa gry i jednocześnie menu główne


## Uruchomienie układu nr 1
func _on_play_button_pressed() -> void:
	GameManager.goto_scene(GameManager.EnumScenes.LEVEL_1)


## Wyświetlenie strony z pomocą
func _on_help_button_pressed() -> void:
	GameManager.goto_scene(GameManager.EnumScenes.HELP_PAGE)


## Wyświetlenie gry z opisem assetów
func _on_credits_button_pressed() -> void:
	GameManager.goto_scene(GameManager.EnumScenes.CREDITS_PAGE)


## Wyjście z gry
func _on_exit_button_pressed() -> void:
	get_tree().quit()
