extends Control
## Menu główne gry
##
## Jest to strona startowa gry i jednocześnie menu główne


## Uruchomienie układu nr 1
func _on_play_button_pressed() -> void:
	GameManager.goto_scene("res://levels/level_1/level_1.tscn")


## Wyświetlenie strony z pomocą
func _on_help_button_pressed() -> void:
	pass # Replace with function body.


## Wyświetlenie gry z opisem assetów
func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


## Wyjście z gry
func _on_exit_button_pressed() -> void:
	get_tree().quit()
