extends Area2D
class_name Coin
## Skrypt zarządza tym co dzieje się ze skarbem
##
## Coin został umieszczony na warstwie kolizji 'Items' i oczekuje kolizji z graczem. W momencie
## gdy taka kolizja się pojawi to wywoływany jest prywatny sygnał 'body_entered'.


## Funkcja wywoływana jest w momencie, gdy gracz wchodz iw kolizję z coinem. Wtedy uruchamiany jest 
## globlany sygnał 'coin_collected' a obiekt 'coin' jest usuwany ze sceny
func _on_body_entered(body: Node2D) -> void:
	print("coin collected")
	GlobalEvents.coin_collected.emit()
	AudioSfx.coin_collected()
	self.queue_free()
