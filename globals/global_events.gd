extends Node
## Skrypt z definicjami sygnałów
##
## Skrypt zawiera tylko definicje globalnych sygnałów, wykorzystywanych w grze

## Zebranie coina
## Emisja sygnału: coin.gd -> _on_body_entered()
## Odbiór sygnału: gama_manager.gd -> _add_point()
signal coin_collected
