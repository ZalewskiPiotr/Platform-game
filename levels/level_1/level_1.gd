extends Node
## Skrypt, który zarządza tym co się dzieje w scenie levelu
##
## Dodatkowy opis :)

#region Stałe i zmienne
@onready var _hud: CanvasLayer = $HUD	# Dostęp do HUD
#endregion


## Podłączenie sygnałów
func _ready() -> void:
	GlobalEvents.coin_collected.connect(_on_coin_collected)

## Aktualziacja HUD w momencie zebrania coina
func _on_coin_collected() -> void:
	_hud.show_score(GameManager.get_score())
