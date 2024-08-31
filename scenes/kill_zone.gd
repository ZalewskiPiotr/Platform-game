extends Area2D

## Skrypt do obsługi śmierci postaci gracza
##
## Działa to tak, że jako wspólna część jest zdefiniowany tylko węzeł typu Area2D oraz skrypt.
## 'KillZone' jest dodane do warstwy floor i ma kolidować z warstwą 'Player'
## Żeby śmierć postaci gracza działała to do sceny levelu trzeba dodać scenę 'KillZone' a potem do
## niej 'CollisionShape2D'. Przykłady:
## Przykład 1. Na dole sceny levelu, w wodzie, znajduje się CollisionShape2D z ustawionym shape na 
## 'WorldBoundaryShape2D'
## Przykład 2. Do sceny przeciwnika trzeba dodać scenę KillZone a do niej dodać CollisionShape2D
## i ustawić odpowiedni shape np. prostokąt
## Po wejściu gracza do takiej strefy (woda lub przeciwnik) uruchamia się zdarzenie _on_body_entered
## w którym robimy to co ma się stać po śmierci gracza

## Funkcja zarządza tym co się wydarzy jak gracz wejdzie w kolizję z obszarem. Generalnie trzeba 
## skończyć grę
## @param: body - obiekt, który wszedł na dany obszar KillZone
func _on_body_entered(body: Node2D) -> void:
	print("You are in kill zone!!!")
	print(body.name)
	GlobalEvents.player_hit.emit()
