extends Node
## Skrypt z definicjami sygnałów
##
## Skrypt zawiera tylko definicje globalnych sygnałów, wykorzystywanych w grze

## Zebranie coina
## Zdarzenie jest wywoływane w momencie, gdy zebrany zostanie coin
## Emisja sygnału:
## - coin.gd -> _on_body_entered()
## Odbiór sygnału:
## - game_manager.gd -> _add_point()
## - level_1.gd -> _on_coin_collected()
signal coin_collected

## Trafienie gracza.
## Zdarzenie jest wywoływane w wowolnym momencie, gdy gracz zostanie trafiony przez obiekty w grze,
## które mogą trafić gracza. Przykłady: zderzenie z przeciwnikiem, wpadnięcie do wody
## Emisja sygnału:
## - kill_zone.gd -> _on_body_entered()
## Odbiór sygnału:
## - game_manager.gd -> _on_player_hit()
signal player_hit
