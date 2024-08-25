extends Node
## Skrypt z definicjami sygnałów
##
## Skrypt zawiera tylko definicje globalnych sygnałów, wykorzystywanych w grze

## Zebranie coina
## Emisja sygnału: 	coin.gd -> _on_body_entered()
## Odbiór sygnału: 	game_manager.gd -> _add_point()
## 					level_1.gd -> _on_coin_collected()
signal coin_collected
