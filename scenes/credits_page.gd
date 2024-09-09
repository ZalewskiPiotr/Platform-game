extends Control


func _input(event: InputEvent) -> void:
	# Wyjście do menu głównego
	if event.is_action_pressed("ESC"):
		_go_to_main_menu()

func _go_to_main_menu() -> void:
	GameManager.reset_score()	# Trzeba wyzerować punkty
	GameManager.goto_scene(GameManager.EnumScenes.START_PAGE)
	

func _on_button_pressed() -> void:
	_go_to_main_menu()
